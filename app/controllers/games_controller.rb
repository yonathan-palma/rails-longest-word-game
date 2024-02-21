require 'open-uri'
require 'json'

API = 'https://wagon-dictionary.herokuapp.com/'
# frozen_string_literal: true

# app/controller/questions_controller.rb
class GamesController < ApplicationController
  def new
    letters = ('a'..'z').to_a
    @grid_letter = Array.new(10) { letters.sample }
  end

  def score
    valid = 0
    attempt = params[:word]
    @msg = "Sorry but #{attempt} does not seem to be a valid english word..."
    grid_copy = params[:grid]
    response_serialized = JSON.parse(URI.open("#{API}#{attempt}").read)
    attempt.downcase.chars.each { |chr| grid_copy.include?(chr) ? grid_copy.sub!(chr, '@') : valid += 1 }
    @msg = "Sorry but #{attempt} can't be built out of #{params[:grid]}" unless valid.zero?
    @msg = "Congratulation! #{attempt} is a valid English word!" if response_serialized['found'] && valid.zero?
    @file = params[:word]
    # raise
  end
end
