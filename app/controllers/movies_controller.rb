class MoviesController < ApplicationController

  # GET /movies
  # GET /movies.xml
  def index
    
    r = Movie.search(params, current_user)
    @movies = r


    # Movie.all

    respond_to do |format|
      format.html {
        
        render :layout => "filter"
      } # index.html.erb
      format.xml { render :xml => @movies }
    end

  end

  # GET /movies/1
  # GET /movies/1.xml
  def show
    @movie = Movie.find(params[:id])

    @user_vote = @movie.rating(current_user)

    if logged_in?
      @p_r = PersonalRatingsHelper.get_rating_by_user_id_and_movie_id(current_user.id, @movie.id)
    end
    # @movie_rating = UserVote.find_by_movie_id_and_user_id(@movie, current_user)

    @pr = @movie.personal_rating(current_user)

    respond_to do |format|
      format.html # show.html.erb
      format.xml { render :xml => @movie }
    end
  end

  # GET /movies/new
  # GET /movies/new.xml
  def new
    @movie = Movie.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml { render :xml => @movie }
    end
  end

  # GET /movies/1/edit
  def edit
    @movie = Movie.find(params[:id])
  end

  # POST /movies
  # POST /movies.xml
  def create
    @movie = Movie.new(params[:movie])


    respond_to do |format|
      if @movie.save
        format.html { redirect_to(@movie, :notice => 'Movie was successfully created.') }
        format.xml { render :xml => @movie, :status => :created, :location => @movie }
      else
        format.html { render :action => "new" }
        format.xml { render :xml => @movie.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /movies/1
  # PUT /movies/1.xml
  def update
    @movie = Movie.find(params[:id])

    respond_to do |format|
      if @movie.update_attributes(params[:movie])
        format.html { redirect_to(@movie, :notice => 'Movie was successfully updated.') }
        format.xml { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml { render :xml => @movie.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /movies/1
  # DELETE /movies/1.xml
  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy

    respond_to do |format|
      format.html { redirect_to(movies_url) }
      format.xml { head :ok }
    end
  end

  def detail
    @movie = Movie.find(params[:id])
    TmdbJob.new.update_tmdb_by_movie_id(@movie.id)
    redirect_to :back
  end

  def update_rating_votes
    MovieJob.new.delay.update_votes_ratings_by_movie_id(params[:id])
    redirect_to :back
  end

  def add_to_list

    params

    redirect_to :back
  end

  
end

