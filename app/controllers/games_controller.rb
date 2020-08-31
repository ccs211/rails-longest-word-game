require 'open-uri'
require 'json'

class GamesController < ApplicationController

  def new
    @letters = Array.new(10) { ('A'..'Z').to_a.sample }
  end

  def score
    @word = params[:word]
    @letters =  params[:letters]

    if inside_grid?(@word, @letters) && english_word?(@word)
      @result = "You win!"
    elsif !inside_grid?(@word, @letters)
      @result = "Your word is not part of the  grid!"
    else
      @result = "Is not an english word!"
    end
  end

  def english_word?(word)
    response = open("https://wagon-dictionary.herokuapp.com/#{word}")
    json = JSON.parse(response.read)
    return json['found']
  end

  def inside_grid?(word, letters)
    word.chars.all? { |letter| word.count(letter) <= letters.count(letter.capitalize) }
  end

end


