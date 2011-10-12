class User < ActiveRecord::Base

  has_many :user_twins
  has_many :users, :through => :user_twins

  has_many :reverse_user_twins, :class_name => "UserTwin", :foreign_key => :twin_id
  has_many :reverse_users, :class_name => "User",
           :through => :reverse_user_twins, :source => :user

  has_many :user_votes
  has_many :movies, :through => :user_votes
  has_many :personal_ratings

  has_one :best_user_twins, :class_name => "UserTwin",
          :order => 'percent desc'

  has_many :movie_lists

  has_many :user_genres
  has_many :genres, :through => :user_genres

  serialize :searches

  attr_accessor :password

  # new columns need to be added here to be writable through mass assignment
  attr_accessible :username, :email, :password, :password_confirmation

  before_save :prepare_password

  #validates_presence_of :username
  #validates_format_of :username, :with => /^[-\w\._@]+$/i, :allow_blank => true, :message => "should only contain letters, numbers, or .-_@"
  validates_format_of :email, :with => /^[-a-z0-9_+\.]+\@([-a-z0-9]+\.)+[a-z0-9]{2,4}$/i

  validates_uniqueness_of :username, :email, :allow_blank => true
  validates :username, :presence => true,
            :format => {:with => /^[-\w\._@]+$/i,
                        :allow_blank => true,
                        :message => "should only contain letters, numbers, or .-_@"}

  validates_presence_of :password, :on => :create
  validates :password, :confirmation => true,
            :length => {:minimum => 4, :allow_blank => true}

  # login can be either username or email address
  def self.authenticate(login, pass)
    user = find_by_username(login) || find_by_email(login)

    if Rails.env.production?
      valid = user && user.password_hash == user.encrypt_password(pass)
    else
      valid = true
    end

    if valid and user
      user.update_twins
      user.update_personal_ratings_for_all_movies
      user.last_logon_at = Time.new
      user.save
    end
    
    return user if valid
  end

  def encrypt_password(pass)
    BCrypt::Engine.hash_secret(pass, password_salt)
  end

  def update_twins
    UsersJob.new.delay.update_twins(id)
  end

  def update_personal_ratings_for_all_movies
    UsersJob.new.delay.update_personal_ratings(id)
  end

  def self.search(params, user)


    r = self
    per_page = 25

    case params[:level].to_i
      when 1..9
        r = r.joins(:reverse_user_twins).where('level = ?', params[:level].to_i)
        r = r.where("user_id = ?", user.id)
#        r = r.where('level = ?', params[:level].to_i)
      else
        params[:level] = 'all'
    end

    params[:search].to_s.split.each do |p|
      if p[/\A\S+:\d\z/i] # XXXXX:NNN format
        twin_name = p[/\A\S+:/].delete(":")
        level = p[/\d+\z/].to_i

        twin = User.where(:username => twin_name).first

        r = r.joins(:reverse_user_twins).where('level = ?', level)
#        r = UsersHelper.user_twins_by_level(level, r.joins(:reverse_user_twins), twin.best_user_twins.percent)

        r = r.where("user_id = ?", twin.id)
#        r = r.username_equals(twin_name)
      elsif p[/^per_page:\d+/i]
        per_page = p[/:\d+/].delete(":").to_i
      else
#        r = r.where('username = ?', p)
        r = r.where('username like ?', "%%%s%%" % p)
      end
    end

    r = r.paginate :per_page => per_page, :page => params[:page]

    r
  end

  def user_twins_by_level(level)
    user_twins.where(:level => level)
#    UsersHelper.user_twins_by_level(level, user_twins, best_user_twins.percent)
  end

  def to_param
    "#{id}-#{username.parameterize}"
  end

  private

  def prepare_password
    unless password.blank?
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_hash = encrypt_password(password)
    end
  end

end
