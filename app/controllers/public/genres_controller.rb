module Public
  class GenresController < ApplicationController
    before_action :set_genre, only: [:show]

    # GET /public/genres
    def index
      @genres = Genre.all
      render :index, status: :ok
    end

    # GET /public/genres/1
    def show
      render :show, status: :ok
    end

    private

    def set_genre
      @genre = Genre.find(params.require(:id))
    rescue ActiveRecord::RecordNotFound
      render json: { error: 'Genre not found' }, status: :not_found
    end
  end
end 