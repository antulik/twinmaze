class ExTmdbMovie < ActiveRecord::Base

  has_one :movie, :foreign_key => :tmdb_id

  serialize :raw_data
end
