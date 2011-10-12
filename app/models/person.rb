class Person < ActiveRecord::Base

  has_many :movie_persons
  has_many :movies, :through => :movie_persons

  scope :actors, where('job = "actor"').limit(10)
end
