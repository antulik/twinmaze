class ExTmdbMoviesController < ApplicationController
  # GET /ex_tmdb_movies
  # GET /ex_tmdb_movies.xml
  def index
    @ex_tmdb_movies = ExTmdbMovie.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @ex_tmdb_movies }
    end
  end

  # GET /ex_tmdb_movies/1
  # GET /ex_tmdb_movies/1.xml
  def show
    @ex_tmdb_movie = ExTmdbMovie.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @ex_tmdb_movie }
    end
  end

  # GET /ex_tmdb_movies/new
  # GET /ex_tmdb_movies/new.xml
  def new
    @ex_tmdb_movie = ExTmdbMovie.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @ex_tmdb_movie }
    end
  end

  # GET /ex_tmdb_movies/1/edit
  def edit
    @ex_tmdb_movie = ExTmdbMovie.find(params[:id])
  end

  # POST /ex_tmdb_movies
  # POST /ex_tmdb_movies.xml
  def create
    @ex_tmdb_movie = ExTmdbMovie.new(params[:ex_tmdb_movie])

    respond_to do |format|
      if @ex_tmdb_movie.save
        format.html { redirect_to(@ex_tmdb_movie, :notice => 'Ex tmdb movie was successfully created.') }
        format.xml  { render :xml => @ex_tmdb_movie, :status => :created, :location => @ex_tmdb_movie }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @ex_tmdb_movie.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /ex_tmdb_movies/1
  # PUT /ex_tmdb_movies/1.xml
  def update
    @ex_tmdb_movie = ExTmdbMovie.find(params[:id])

    respond_to do |format|
      if @ex_tmdb_movie.update_attributes(params[:ex_tmdb_movie])
        format.html { redirect_to(@ex_tmdb_movie, :notice => 'Ex tmdb movie was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @ex_tmdb_movie.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /ex_tmdb_movies/1
  # DELETE /ex_tmdb_movies/1.xml
  def destroy
    @ex_tmdb_movie = ExTmdbMovie.find(params[:id])
    @ex_tmdb_movie.destroy

    respond_to do |format|
      format.html { redirect_to(ex_tmdb_movies_url) }
      format.xml  { head :ok }
    end
  end
end
