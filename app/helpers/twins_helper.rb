module TwinsHelper
  def self.search_by_level_and_user_path(user, level)
    params ={}
    params[:search] = "in:twins %s:%s" % [user.username, level]

    params.merge! :action => :index, :controller => :twins
  end
end
