module RatingHelper
  def self.rating_to_string(rating)
    if rating > 9
      "best"
    elsif rating > 8
      "good-best"
    elsif rating > 7
      "good"
    elsif rating > 6
      "okay-good"
    elsif rating > 5
      "okay"
    elsif rating > 4
      "average"
    elsif rating > 3
      "bad"
    elsif rating > 2
      "really bad"
    elsif rating > 1
      "awful"
    else
      "unknown"
    end
  end
end
