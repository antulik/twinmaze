class SearchController < ApplicationController

  before_filter :login_required, :except => :search

  def index
    search
  end

  def search
      ctrl = params[:where].empty? ? :movies : params[:where]
      redirect_to params.merge! :action => :index, :controller => ctrl
  end

  def save

    return if not current_user

    if not params[:search_name] or  params[:search_name].to_s.size == 0
      alert = "name cannot be empty"
      redirect_to :back, :alert => alert
      return
    else
      search = {}
      search[:k] = params[:k]
      search[:view] = params[:view]
      search[:sort] = params[:sort]
      search[:search] = params[:search]
      search[:search_name] = params[:search_name]
#      search[:controller] = params[:controller]

      current_user.searches = Array.new if not current_user.searches or not current_user.searches.is_a?(Array)
      current_user.searches << search

      # little hack to get it working
      current_user.email = "#{current_user.username}@#{current_user.username}.com" if not current_user.email
      current_user.save

    end
    redirect_to :back
  end

  def delete
    return if not current_user

    if params[:search_name] and  params[:search_name].to_s.size > 0
      arr = current_user.searches.to_a

      arr.each do |x|
        if x[:search_name] == params[:search_name]
          arr.delete(x)
        end
      end
      current_user.searches = arr
      current_user.save
      params.delete(:search_name)
    end
    
    redirect_to :back, params
  end


end
