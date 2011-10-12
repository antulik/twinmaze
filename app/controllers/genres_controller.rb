class GenresController < ApplicationController
  
  def index
    genre = Genre.find_by_name(params[:genre])

    if genre
      @movies = Movie.search(params, current_user, genre.movies)

    end
    @genres = Genre.search(params)



    respond_to do |format|
      format.html { render :layout => 'filter' } # index.html.erb
      format.xml { render :xml => @genres }
    end
  end

  def show
    @genre = Genre.find(params[:id])
    @movies = Movie.search(params, current_user, @genre.movies)

    respond_to do |format|
      format.html # show.html.erb
      format.xml { render :xml => @movies }
    end
  end

  def edit
  end

end
