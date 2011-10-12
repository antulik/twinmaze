class MovieJob
  def update_votes_ratings_by_movie_id(movie_id)
    update_votes_ratings :id => movie_id
  end

  def update_votes_ratings_all
    update_votes_ratings
  end

  def update_votes_ratings(params = {})
    w = ""
    w = "where id = %d" % params[:id] if params[:id]

    sql = "update movies as m
set votes_rating_1 = (select count(*) from user_votes where movie_id = m.id and rating = 1)
,votes_rating_2 = (select count(*) from user_votes where movie_id = m.id and rating = 2)
,votes_rating_3 = (select count(*) from user_votes where movie_id = m.id and rating = 3)
,votes_rating_4 = (select count(*) from user_votes where movie_id = m.id and rating = 4)
,votes_rating_5 = (select count(*) from user_votes where movie_id = m.id and rating = 5)
,votes_rating_6 = (select count(*) from user_votes where movie_id = m.id and rating = 6)
,votes_rating_7 = (select count(*) from user_votes where movie_id = m.id and rating = 7)
,votes_rating_8 = (select count(*) from user_votes where movie_id = m.id and rating = 8)
,votes_rating_9 = (select count(*) from user_votes where movie_id = m.id and rating = 9)
,votes_rating_10 = (select count(*) from user_votes where movie_id = m.id and rating = 10)
,votes_rating_total = (select count(*) from user_votes where movie_id = m.id)
,votes_rating = (select sum(rating)/count(*) from user_votes where movie_id = m.id)
,votes_rating_updated_at = CURRENT_TIMESTAMP %s;" % w
    ActiveRecord::Base.connection.execute(sql)

  end


end