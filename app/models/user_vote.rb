class UserVote < ActiveRecord::Base

  belongs_to :user
  belongs_to :movie

  validates :user_id, :presence => true
  validates :movie_id, :presence => true

  attr_accessible  :movie_id, :rating

  def self.get_by_user_and_movie(user_id, movie_id)
    self.where(:user_id => user_id, :movie_id => movie_id).first
  end

end
