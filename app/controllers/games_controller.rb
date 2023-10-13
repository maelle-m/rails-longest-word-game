require 'json'
require 'open-uri'

class GamesController < ApplicationController
  def new
    alphabet = ('A'..'Z').to_a
    @letters = 10.times.map { alphabet.sample }
  end

  def score
    result = {}

    @attempt = params[:word].split("")
    @letters = params[:letters].split("")

    if @letters && word_in_grid?(params[:word], @letters)
      if valid_word?(params[:word])
        result[:message] = "Well done"
      else
        result[:message] = "Not an English word"
      end
     #else
      #result[:message] = "Word not in the grid"
    end

  @result_message = result[:message]
  end

private

def valid_word?(word)
  url = "https://wagon-dictionary.herokuapp.com/#{word}"
  test_json = URI.open(url).read
  results = JSON.parse(test_json)
  results['found']
end

def word_in_grid?(word, letters)
(@letters - @attempt).empty?
  #return false unless letters
  #word.chars.all? { |char| word.chars.count(char) <= letters.count(char) }
end
end
