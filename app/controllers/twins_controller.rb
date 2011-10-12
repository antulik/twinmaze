class TwinsController < ApplicationController

  before_filter :login_required, :except => [:index, :show]

  # GET /users
  # GET /users.xml
  def index
    @users = User.search(params, current_user)

    respond_to do |format|
      format.html {
        render 'search.html.erb', :layout => 'filter'
      }
    end
  end

  def profile
    params[:id] = current_user.id
    show
  end

  def show
    @user = User.find(params[:id])
    @top_twins = @user.user_twins.order('percent desc').limit(6)
    @genres = @user.user_genres.order('avg_rating desc')
    
    render 'show.html.erb'
  end

  def update_twins
    @user = User.find(params[:id])
#    @user.update_twins
    UsersJob.new.update_twins(@user.id)
    
    redirect_to :back
  end

  def update_personal_ratings
    UsersJob.new.delay.update_personal_ratings(params[:id])
    redirect_to :back
  end

  def update_genres
    UsersJob.new.update_genres(params[:id])
    redirect_to :back
  end


  def ratings
    @user = User.find(params[:id])
    @twin = @user
    params[:k_2] ||= 'watched'

    @movies = Movie.search(params, current_user, @user.movies )
  end

end
