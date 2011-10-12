class MovieList < ActiveRecord::Base
  belongs_to :user
  has_many :movie_list_items
  has_many :movies, :through => :movie_list_items

  validates :user_id, :presence => true

  validates :name, :presence => true

  attr_accessible :name, :is_opened, :to_approve

  def self.search(params, user = nil)

    per_page = 25
    r = self.includes(:user)

    case params[:list_type]
      when 'opened'
        r = r.where('is_opened = ?', true)
      when 'closed'
        r = r.where('is_opened = ?', false)
      else
        params[:list_type] = 'all'
    end


    search_params = params[:search].to_s.split
    search_params.each do |p|
      if false
      else

        r = r.where('name like ? or users.username like ?', "%%%s%%" % p, p )
      end
    end

   
    r = r.paginate :per_page => per_page, :page => params[:page]
    return r
  end

  def to_param
    "#{id}-#{name.parameterize}"
  end
end
