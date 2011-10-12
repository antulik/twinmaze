module MoviesHelper


  def self.get_rating_percent(movie, rating)
    return 0 if not movie
    votes = 0
    begin
      case rating
        when 5
          votes = movie.votes_rating_10 + movie.votes_rating_9
        when 4
          votes = movie.votes_rating_8 + movie.votes_rating_7
        when 3
          votes = movie.votes_rating_6 + movie.votes_rating_5
        when 2
          votes = movie.votes_rating_4 + movie.votes_rating_3
        when 1
          votes = movie.votes_rating_2 + movie.votes_rating_1
      end
      votes.to_f/movie.votes_rating_total.to_f*100
    rescue
      0
    end
  end

  def self.get_rating_percent_tmdb(movie, rating)
    return 0 if not movie.tmdb_rating
    rate = movie.tmdb_rating
    rate = 10 - rate if rating == 1
    rate*10
  end



  def self.search_by_user_path(user)
    params ={}
    params[:search] = "twin:%s" % user.username

    params.merge! :action => :index, :controller => :movies
  end

  def rating_to_css(rating)
    color = "white"
    if rating > 9
      color = "r_best"
    elsif rating > 8
      color = "r5"
    elsif rating > 6
      color = "r4"
    elsif rating > 4
      color = "r3"
    elsif rating > 2
      color = "r2"
    elsif rating > 0
      color = "r1"
    end
    color
  end

end
