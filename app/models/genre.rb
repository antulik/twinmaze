class Genre < ActiveRecord::Base
  has_many :movie_genres
  has_many :movies, :through => :movie_genres

  has_many :user_genres
  has_many :users, :through => :user_genres

  def self.search(params, user = nil)

    per_page = 50
    r = self

    search_params = params[:search].to_s.split
    search_params.each do |p|
      if false
      else
        r = r.where('name like ?', "%%%s%%" % p )
      end
    end

    r = r.order('name asc')

    r = r.paginate :per_page => per_page, :page => params[:page]
    return r
  end

  def to_param
    "#{id}-#{name.parameterize}"
  end
end
