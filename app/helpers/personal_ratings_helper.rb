module PersonalRatingsHelper


  def self.get_rating_by_user_id_and_movie_id(user_id, movie_id)
    rating = nil
    # Comment out to force update
#    rating = PersonalRating.where(:user_id => user_id, :movie_id => movie_id).first

    if not rating
      UsersJob.new.update_personal_ratings(user_id, movie_id)
      rating = PersonalRating.where(:user_id => user_id, :movie_id => movie_id).first
    end

    return rating
  end

  def self.get_color_by_level_and_rating(level, rating)
    is_opacity = false
    r, g, b = 0, 0, 0
    rate = rating.ceil
    case rate
      when 0 then
        r, g, b = 255, 255, 255
      when 1 then
        r, g = 230, 0
      when 2 then
        r, g = 230, 51
      when 3 then
        r, g = 230, 102
      when 4 then
        r, g = 230, 153
      when 5 then
        r, g = 230, 204
      when 6 then
        r, g = 230, 230
      when 7 then
        r, g = 192, 230
      when 8 then
        r, g = 128, 230
      when 9 then
        r, g = 64, 230
      when 10 then
        r, g = 0, 230
    end

    opacity = ((10 - level)/9.to_f)**2
    if is_opacity
      style = "rgba(%d, %d, %d, %f)" % [r, g, b, opacity]
    else
      r, g, b = tint_rgb_color(r, g, b, opacity)
      style = "#%02x%02x%02x" % [r, g, b]
    end

    return style
  end

  def self.tint_color(color, tint)
    (tint * color) + (255 * (1 - tint))
  end

  def self.tint_rgb_color(r, g, b, tint)
    return tint_color(r, tint), tint_color(g, tint), tint_color(b, tint)
  end

end
