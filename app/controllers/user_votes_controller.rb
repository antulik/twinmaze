class UserVotesController < ApplicationController

  before_filter :login_required

  # GET /user_votes
  # GET /user_votes.xml
  def index
    @user_votes = UserVote.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml { render :xml => @user_votes }
    end
  end

  # GET /user_votes/1
  # GET /user_votes/1.xml
  def show
    @user_vote = UserVote.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml { render :xml => @user_vote }
    end
  end

  # GET /user_votes/new
  # GET /user_votes/new.xml
  def new
    @user_vote = UserVote.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml { render :xml => @user_vote }
    end
  end

  # GET /user_votes/1/edit
  def edit
    @user_vote = UserVote.find(params[:id])
  end

  # POST /user_votes
  # POST /user_votes.xml
  def create
    @user_vote = UserVote.new(params[:user_vote])

    @user_vote.user = current_user
    @user_vote.rating_date = Time.now
    

    respond_to do |format|
      format.js { head :ok}
      if @user_vote.save
        format.html { redirect_to(@user_vote.movie, :notice => 'Movie rating was successfully created.') }
        format.xml { render :xml => @user_vote, :status => :created, :location => @user_vote }
      else
        format.html { render :action => "new" }
        format.xml { render :xml => @user_vote.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /user_votes/1
  # PUT /user_votes/1.xml
  def update
    @user_vote = UserVote.find(params[:id])

    @user_vote.rating_date = Time.now

    respond_to do |format|
      if @user_vote.update_attributes(params[:user_vote])
        format.html { redirect_to(@user_vote.movie, :notice => 'Movie rating was successfully updated.') }
        format.xml { head :ok }
        format.js { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml { render :xml => @user_vote.errors, :status => :unprocessable_entity }
        format.js { head :ok }
      end
    end
  end

  # DELETE /user_votes/1
  # DELETE /user_votes/1.xml
  def destroy
    @user_vote = UserVote.find(params[:id])

    @user_vote.user.update_watched_movies
    @user_vote.destroy

    respond_to do |format|
      format.html { redirect_to(user_votes_url) }
      format.xml { head :ok }
    end
  end

  def vote
    user = current_user
    return if not user
    movie_id = params[:movie_id]
    rating = params[:rating]

    vote = UserVote.get_by_user_and_movie(user.id, movie_id)
    
    vote = UserVote.new if not vote

    if not rating
      vote.destroy
    else
      vote.rating = rating
      vote.user = user
      vote.movie_id = movie_id
      vote.save
    end

    UsersJob.new.delay.update_personal_ratings(user.id, movie_id )

    head :ok
  end

end
