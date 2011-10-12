class MovieListItem < ActiveRecord::Base

  belongs_to :movie
  belongs_to :movie_list

end
