class MoviesController < ApplicationController

  def index
    @movies = Movie.order("RANDOM()").where("votes > 10000").limit(20)
  end

end