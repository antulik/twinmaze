class PersonalRating < ActiveRecord::Base
  belongs_to :movie
  belongs_to :user

  
  def get_rating_and_votes_by_level level
    rating, votes = self["l" + level.to_s + "_rating"]|| 0, self["l" + level.to_s + "_votes"] || 0
    return rating, votes
  end
end
