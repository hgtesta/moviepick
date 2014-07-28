class PicksController < ApplicationController

  def index
    @movies = Movie.order("RANDOM()").where("votes > 10000").limit(10)
    @picked_movies = Movie.find(session[:picks] || [])
  end

  def create
    @movie_id = params[:movie_id]
    @movie = Movie.find(@movie_id)

    session[:picks] ||= []
    session[:picks] << @movie_id

    # Save picks if user is logged in
    if @user = current_user
      @user.movies << @movie_id
      @user.save!
    end

    redirect_to :picks
  end

  def destroy
    session[:picks].delete(params[:id])

    # Save picks if user is logged in
    if @user = current_user
      @user.movies.delete(@movie_id)
      @user.save!
    end

    redirect_to :picks

  end

end
