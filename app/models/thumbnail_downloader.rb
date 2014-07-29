require 'net/http'
require 'json'
require 'open-uri'

class ThumbnailDownloader 
  IMDBAPI = "http://www.omdbapi.com/"
  DOWNLOAD_FOLDER = "#{ Rails.root }/app/assets/images/posters"

  def download(movie)
    poster = get_poster_url movie
    if poster
      pic_url = URI(poster) 
      file    = make_file_name movie, File.extname(pic_url.path)
      download_pic pic_url, file
      file
    end
  end

  private

  def make_file_name(movie, ext)
    title = movie.title.downcase.gsub(" ", "-")
    ext   = ".#{ext}" if ext.index(".") != 0 
    year = movie.year_part ? 
           "#{ movie.year }-#{ movie.year_part }" :
           movie.year
    "#{ title }-#{ year }#{ ext }"
  end

  def download_pic(url, local)
    File.open("#{DOWNLOAD_FOLDER}/#{local}", "wb") do |file|
      open(url, "rb") do |remote|
        file.write(remote.read)
      end
    end
  end

  def get_poster_url(movie)
    m = search movie
    return nil unless m
    response = request({ i: m[:imdbID] })
    return nil unless response[:Response] == "True"
    response[:Poster] == "N/A" ? nil : response[:Poster]
  end

  def search(movie)
    params   = { s: movie.title, y: movie.year }
    response = request(params)
    movies   = filter(response, movie.title, movie.year)
    movies.size > 0 and movie.year_part ? 
     movies[movie.year_part - 1] : 
     movies.first  
  end

  def filter(response, title, year)
    return [] unless response[:Search]
    response[:Search].select do |movie|
      movie[:Title]     == title and
      movie[:Year].to_i == year  and
      movie[:Type]      == "movie"
    end.sort { |a, b| a[:imdbID] <=> b[:imdbID] }
  end

  def request(params)
    url       = URI(IMDBAPI)
    url.query = URI.encode_www_form(params)
    response  = Net::HTTP.get_response(url)
    JSON.parse(response.body, symbolize_names: true)
  end
end
