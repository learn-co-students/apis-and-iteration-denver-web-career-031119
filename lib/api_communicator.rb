require 'rest-client'
require 'json'
require 'pry'

def get_and_parse_web_request(webUrl)
  response_string = RestClient.get(webUrl)
  response_hash = JSON.parse(response_string)
end

def get_character_movies_from_api(character_name)
  #make the web request
  response_hash = get_and_parse_web_request('http://www.swapi.co/api/people/')
  # puts response_hash["results"]
  response_hash["results"].each do |info|
    if info["name"] == character_name
      array_films = info["films"].map do |film|
        get_and_parse_web_request(film)
      end
      return array_films
    end
  end

  # iterate over the response hash to find the collection of `films` for the given
  #   `character`
  # collect those film API urls, make a web request to each URL to get the info
  #  for that film
  # return value of this method should be collection of info about each film.
  #  i.e. an array of hashes in which each hash reps a given film
  # this collection will be the argument given to `print_movies`
  #  and that method will do some nice presentation stuff like puts out a list
  #  of movies by title. Have a play around with the puts with other info about a given film.
end


def print_movies(films)
  # some iteration magic and puts out the movies in a nice list
  puts "Character is in the following films: "
  films.each do |info|
    puts info["title"]
  end
end

def show_character_movies(character)
  films = get_character_movies_from_api(character)
  print_movies(films)
end

## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
