require "open-uri"
require "nokogiri"
require "pry"
require "httparty"

require "pet_finder/version"
require "pet_finder/cli"
require "pet_finder/scraper"
require "pet_finder/pet"

module PetFinder
  class Error < StandardError; end
  # Your code goes here...
end
