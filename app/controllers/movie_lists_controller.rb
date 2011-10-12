class MovieListsController < ApplicationController
  before_filter :login_required, :only => :create

  # GET /movie_lists
  # GET /movie_lists.xml
  def index
    @movie_lists = MovieList.search(params)

    respond_to do |format|
      format.html { render :layout => 'filter' } # index.html.erb
      format.xml { render :xml => @movie_lists }
    end
  end

  # GET /movie_lists/1
  # GET /movie_lists/1.xml
  def show
    @movie_list = MovieList.find(params[:id])
    @movies = Movie.search(params, current_user, @movie_list.movies)

    respond_to do |format|
      format.html # show.html.erb
      format.xml { render :xml => @movie_list }
    end
  end

  # GET /movie_lists/new
  # GET /movie_lists/new.xml
  def new
    @movie_list = MovieList.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml { render :xml => @movie_list }
    end
  end

  # GET /movie_lists/1/edit
  def edit
    @movie_list = MovieList.find(params[:id])
  end

  # POST /movie_lists
  # POST /movie_lists.xml
  def create
    @movie_list = MovieList.new(params[:movie_list])

    @movie_list.user = current_user

    respond_to do |format|
      if @movie_list.save
        format.html { redirect_to(@movie_list, :notice => 'Movie list was successfully created.') }
        format.xml { render :xml => @movie_list, :status => :created, :location => @movie_list }
      else
        format.html { render :action => "new" }
        format.xml { render :xml => @movie_list.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /movie_lists/1
  # PUT /movie_lists/1.xml
  def update
    @movie_list = MovieList.find(params[:id])

    respond_to do |format|
      if @movie_list.update_attributes(params[:movie_list])
        format.html { redirect_to(@movie_list, :notice => 'Movie list was successfully updated.') }
        format.xml { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml { render :xml => @movie_list.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /movie_lists/1
  # DELETE /movie_lists/1.xml
  def destroy
    @movie_list = MovieList.find(params[:id])
    @movie_list.destroy

    respond_to do |format|
      format.html { redirect_to(movie_lists_url) }
      format.xml { head :ok }
    end
  end

  def delete_movie
    @movie_list_item = MovieListItem.where(:movie_id => params[:movie_id]).
        where(:movie_list_id => params[:id]).first
    @movie_list_item.destroy if @movie_list_item

    @movie = Movie.find(params[:movie_id])

    respond_to do |format|
      format.html { redirect_to :back }
      format.js { render 'add_movie' }
    end
  end

  def add_movie
    list = MovieList.find(params[:id])
    @movie = Movie.find(params[:movie_id])

    return if not list or not @movie

    item = MovieListItem.new
    item.movie_list = list
    item.movie = @movie
    item.save

    respond_to do |format|
      format.html { redirect_to :back }
      format.js
    end
  end
end
