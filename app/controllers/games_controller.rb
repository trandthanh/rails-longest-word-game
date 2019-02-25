

class GamesController < ApplicationController

  def new
    # Display a random grid
    @letters = []
    10.times do
      @letters << ('A'..'Z').to_a.sample
    end
    # Display a form, submitted with POST to the score action.
  end

  def score
    @letters = params[:grid]
    @solution = params[:solution]
    if included? == false
      @answer = "Sorry but #{@solution} can't be built out of #{@letters.chars.join("")}."
    elsif english_word?(@solution)
      @answer = "Congratulations! #{@solution} is a valid English word!"
    else
      @answer = "Sorry but #{@solution} does not seem to be a valid English word..."
    end
  end

  def english_word?(solution)
    response = open("https://wagon-dictionary.herokuapp.com/#{solution}")
    json = JSON.parse(response.read)
    return json['found']
  end

  def included?
    params[:solution].chars.all? { |letter| params[:solution].count(letter) <= params[:grid].count(letter) }
  end
end

# 3 scenarios
# the word cant be build out of the original grid
# the word is valid according to the grid but is not a valid English word
# the word is valid according to the grid and is an English word

