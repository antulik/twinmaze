class UsersJob

  def update_twins_and_personal_ratings(user_id)
    update_twins(user_id)
    update_genres(user_id)
    update_personal_ratings(user_id)
  end

#  handle_asynchronously :update_twins_and_personal_ratings, :priority => 20


  def update_personal_ratings(user_id, movie_id = nil)

#    criteria = Array.new
#    criteria << "movie_id = %d" % movie_id if movie_id
#    criteria << "user_id = %d" % user_id if user_id
#    w = criteria.blank? ? "" : "where " + criteria.join(" and ")
#    sql = "Delete from `personal_ratings` %s" % w
#    ActiveRecord::Base.connection.execute(sql)


    criteria = Array.new
    criteria << "votes.movie_id = %d" % movie_id if movie_id
    criteria << "twins.user_id = %d" % user_id if user_id
    w = criteria.blank? ? "" : "where " + criteria.join(" and ")
    power = 2
    rating_order_power = 1.5

    sql = "REPLACE INTO `personal_ratings`
(`user_id`,`movie_id`,`updated_at`,
`l9_rating`,`l8_rating`,`l7_rating`,`l6_rating`,`l5_rating`,
`l4_rating`,`l3_rating`,`l2_rating`,`l1_rating`,
`l9_votes`,`l8_votes`,`l7_votes`,`l6_votes`,`l5_votes`,
`l4_votes`,`l3_votes`,`l2_votes`,`l1_votes`,
`best_rating`, `best_rating_votes_level`, `best_rating_order`,`total_votes`,
`watched`
)
select t.user_id, t.movie_id, CURRENT_TIMESTAMP,
sum(l9_rating),sum(l8_rating),sum(l7_rating),sum(l6_rating),sum(l5_rating),
sum(l4_rating),sum(l3_rating),sum(l2_rating),sum(l1_rating),
sum(l9_votes),sum(l8_votes),sum(l7_votes),sum(l6_votes),sum(l5_votes),
sum(l4_votes),sum(l3_votes),sum(l2_votes),sum(l1_votes),
sum(rating_points_sum)/sum(vote_points_sum),

if(sum(votes) > 20, ln(sum(votes)), -15),

Power(sum(rating_points_sum)/sum(vote_points_sum), #{rating_order_power} ) +
if(sum(votes) > 20, ln(sum(votes)), -15),

sum(votes),
mine.rating is not null

from (
    select twins.user_id as user_id,
    votes.movie_id as movie_id, level as level,
    avg(rating) as rating, count(*) as votes,
    Power(10-level, ln(count(*))/ln(2.5)) * count(*) * avg(rating) as rating_points_sum,
    Power(10-level, ln(count(*))/ln(2.5)) * count(*) as vote_points_sum,
    ln(count(*))/ln(2.5) as power,
    case level when 9 then avg(rating) end as l9_rating,
    case level when 8 then avg(rating) end as l8_rating,
    case level when 7 then avg(rating) end as l7_rating,
    case level when 6 then avg(rating) end as l6_rating,
    case level when 5 then avg(rating) end as l5_rating,
    case level when 4 then avg(rating) end as l4_rating,
    case level when 3 then avg(rating) end as l3_rating,
    case level when 2 then avg(rating) end as l2_rating,
    case level when 1 then avg(rating) end as l1_rating,
    case level when 9 then count(*) end as l9_votes,
    case level when 8 then count(*) end as l8_votes,
    case level when 7 then count(*) end as l7_votes,
    case level when 6 then count(*) end as l6_votes,
    case level when 5 then count(*) end as l5_votes,
    case level when 4 then count(*) end as l4_votes,
    case level when 3 then count(*) end as l3_votes,
    case level when 2 then count(*) end as l2_votes,
    case level when 1 then count(*) end as l1_votes
    from user_twins as twins join user_votes as votes
    on twins.twin_id = votes.user_id
    %s
    group by twins.user_id, twins.level, votes.movie_id
) as t
left outer join user_votes as mine on
mine.user_id = t.user_id and mine.movie_id = t.movie_id
group by user_id, movie_id" % w
    ActiveRecord::Base.connection.execute(sql)

    # don't update for a single movie
    if not movie_id
      user = User.find(user_id)
      user.personal_ratings_updated_at = Time.new
      user.save
    end
  end

  def update_twins(user_id)

    return nil if not user_id
    def_min_match = 15
    percent = 0.02
    root_number = 1.5

    votes_count = UserVote.where(:user_id => user_id).count

    min_match = votes_count*percent
    min_match = votes_count**(1.0/root_number)
    min_match = def_min_match if min_match < def_min_match
    min_match = min_match.floor

    sql = "REPLACE INTO `user_twins`
(`user_id`, `twin_id`, `avg_difference`,
`percent`, `movies_matched`, `level`, `updated_at`)

(select user_id,twin_id, avg_difference, percent, movies_matched,
if(percent > 92.5, 1,
if(percent > 90, 2,
if(percent > 87.5, 3,
if(percent > 85, 4,
if(percent > 82.5, 5,
if(percent > 80, 6,
if(percent > 77.5, 7,
if(percent > 75, 8, 9)))))))),
CURRENT_TIMESTAMP
from
    (select sr.user_id as user_id, sr.twin_id as twin_id,
    Sum(single_points) as avg_difference,
    (10-(Sum(single_points)/count(*)))*10 as percent, count(*) as movies_matched
    from
        (select mr1.user_id as user_id,
                mr2.user_id as twin_id,
                ABS(mr1.rating-mr2.rating) as single_points
        from user_votes as mr1 join user_votes as mr2
        on mr1.movie_id = mr2.movie_id and mr1.user_id <> mr2.user_id
        where mr1.user_id = %d)
    as sr
    group by sr.user_id, sr.twin_id
    having count(*) >= %d) as t2
);" % [user_id, min_match]

    ActiveRecord::Base.connection.execute(sql)

    UserTwin.delete_all(["user_id=? and movies_matched < ? ", user_id, min_match])
#    UserTwin.delete_all(["user_id=?", user_id])

    user = User.find(user_id)

    if user
      user.twins_updated_at = DateTime.now
      user.save
    end
  end

  def update_genres(user_id = nil)
    w = ""
    w = "where `user_votes`.`user_id` = %d" % user_id.to_i if user_id

    sql = "REPLACE INTO `user_genres`
(`user_id`, `genre_id`, `movies_count`, `avg_rating`, `updated_at`)

(SELECT user_id, genre_id, count(*), avg(rating), CURRENT_TIMESTAMP
FROM `user_votes`
inner join `movie_genres`
on `movie_genres`.`movie_id` = `user_votes`.`movie_id`
%s
group by user_id, genre_id);" % w

    ActiveRecord::Base.connection.execute(sql)

    # TODO: remove user_genres which haven't been updated

  end


end