class MoviesController < ApplicationController
  include Authenticatable
  before_action :set_movie, only: %i[ show update destroy ]

  # GET /movies
  def index
    @movies = Movie.all

    render :index, status: :ok
  end

  # GET /movies/1
  def show
    render json: @movie
  end

  # POST /movies
  def create
    @movie = Movie.new(movie_params)

    if @movie.save
      render json: @movie, status: :created, location: @movie
    else
      render json: @movie.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /movies/1
  def update
    if params[:movie][:genre_ids].present? && !valid_genres?
      render json: { error: "One or more genres do not exist" }, status: :unprocessable_entity
      return
    end

    if @movie.update(movie_params)
      render :show, status: :ok
    else
      render json: @movie.errors, status: :unprocessable_entity
    end
  end

  # DELETE /movies/1
  def destroy
    @movie.destroy!
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_movie
      @movie = Movie.find(params.require(:id))
    end

    # Only allow a list of trusted parameters through.
    def movie_params
      params.require(:movie).permit(:title, :description, :poster_image_url, genre_ids: [])
    end

    def valid_genres?
      genre_ids = params[:movie][:genre_ids]
      Genre.where(id: genre_ids).count == genre_ids.count
    end
end
