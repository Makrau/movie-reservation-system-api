module Public
  class MoviesController < ApplicationController
    before_action :set_movie, only: [:show]

    # GET /public/movies
    def index
      @movies = Movie.all
      render :index, status: :ok
    end

    # GET /public/movies/1
    def show
      render json: @movie
    end

    private

    def set_movie
      @movie = Movie.find(params.require(:id))
    rescue ActiveRecord::RecordNotFound
      render json: { error: 'Movie not found' }, status: :not_found
    end
  end
end 