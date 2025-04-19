class GenresController < ApplicationController
  include Authenticatable
  before_action :set_movie_genre, only: [ :show ]

  # GET /genres
  def index
    @genres = Genre.all
    render json: @genres
  end

  # GET /genres/1
  def show
    render json: @movie_genre
  end

  private
    def set_movie_genre
      @movie_genre = Genre.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      render json: { error: "Genre not found" }, status: :not_found
    end
end
