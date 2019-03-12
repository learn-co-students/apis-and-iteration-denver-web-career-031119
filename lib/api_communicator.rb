require 'rest-client'
require 'json'
require 'pry'

def get_character_movies_from_api(character_name)
  #make the web request
  response_string = RestClient.get('http://www.swapi.co/api/people/')
  response_hash = JSON.parse(response_string)

  films_arr = []

  # response_hash['results'].each do |character_data|
  #   if character_data.has_value?(character_name)
  #     puts 'Character found'
  #   else
  #     puts 'characyer not found breh'
  #   end
  # end
  names_arr = []
  response_hash['results'].each do |character_data|
    names_arr << character_data['name']
  end
  if !names_arr.include?(character_name)
    puts "not found breh"
    return 'no'
  end

  response_hash['results'].each do | character_data |
    # character['films'] if character['name'] == character_name
    if character_data['name'] == character_name
      return character_data['films']
    end
  end

  # collect those film API urls, make a web request to each URL to get the info
  #  for that film
  # return value of this method should be collection of info about each film.
  #  i.e. an array of hashes in which each hash reps a given film
  # this collection will be the argument given to `print_movies`
  #  and that method will do some nice presentation stuff like puts out a list
  #  of movies by title. Have a play around with the puts with other info about a given film.
end
#get_character_movies_from_api('C-3PO')
def print_movies(films)
  # some iteration magic and puts out the movies in a nice list
  puts films.map { | film | JSON.parse(RestClient.get(film))['title'] }
end

def show_character_movies(character)
  if get_character_movies_from_api(character) == 'no'
    puts 'NO'
  else
    films = get_character_movies_from_api(character)
    print_movies(films)
  end
  # binding.pry
end
#show_character_movies('Luke Skywalker')
## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
