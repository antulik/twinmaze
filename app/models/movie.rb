class Movie < ActiveRecord::Base
  has_many :user_votes

  has_many :movie_genres
  has_many :genres, :through => :movie_genres

  has_many :movie_persons
  has_many :people, :through => :movie_persons

  has_many :movie_images
  has_many :personal_ratings
  has_many :movie_list_items
  has_many :movie_lists, :through => :movie_list_items

  belongs_to :ex_tmdb_movie, :foreign_key => :tmdb_id, :primary_key => :tmdb_id


  

  def rating(user)
    @rating = UserVote.find_by_movie_id_and_user_id(self, user)

    if not @rating
      @rating = UserVote.new
    end

    @rating
  end

  def update_personal_rating
    PersonalRatingsHelper.update_personal_ratings(current_user.id, id)
  end


  def self.search(params, user, r = nil)
    params[:k] = nil if not user
    params[:view] ||= :poster

    per_page = 20

    twins = Array.new


    r ||= self
    if user
      r = r.joins("left outer join personal_ratings on personal_ratings.movie_id = movies.id and personal_ratings.user_id = #{user.id}")
#      r = r.includes(:personal_ratings)
    end

    case params[:k]
      when 'watched'
        r = r.where('watched = ?', true)
      when 'unwatched'
        r = r.where('watched = ?', false)
        params[:sort] = params[:sort] || :personal_rating
      else
        params[:k] = 'all'
    end

    case params[:sort].to_s
      when 'year'
        order = 'year desc'
      when 'name'
        order = 'title asc'
      when 'twin_rating'
        order = 'best_rating desc'
        r = r.where('total_votes > 20')
      when 'recommended'
        order = 'best_rating_order desc'
      when 'twin_popularity'
        order = 'total_votes desc'
      when 'global_popularity'
        order = 'votes_rating_total desc'
      when 'global_rating'
        order = 'votes_rating desc'
      else
        order = 'votes_rating_total desc'
        params[:sort] = 'global_popularity'
    end

    if params[:per_page].to_i > 0 and params[:per_page].to_i <= 200
      per_page = params[:per_page].to_i
    else
      params[:per_page] = per_page
    end

    if params[:runtime].to_i > 0
      r = r.where('runtime <= ?', params[:runtime].to_i)
    else
      params[:runtime] = 'all'
    end

    search_params = params[:search].to_s.split
    search_params.each do |p|
      if p.to_i > 1950 and p.to_i < 2020
        r = r.where('movies.year = ?', p)
      elsif p[/^year[><]/i]
        min, max = get_min_max(p)
        r = r.where('movies.year >= ?', min) if min
        r = r.where('movies.year <= ?', max) if max
      elsif p[/^tmdb[<>]/i]
        min, max = get_min_max(p)
        r = r.where('movies.tmdb_rating >= ?', min) if min
        r = r.where('movies.tmdb_rating <= ?', max) if max
      elsif p[/^twin:/i]
        twins << p[/:\S+/i].delete(":")
      elsif p[/^per_page:\d+/i]
        per_page = p[/:\d+/].delete(":").to_i
      elsif p[/^pr[<>]/i] and user
        min, max = get_min_max(p)

        r = r.where('personal_ratings.best_rating > ?', min) if min
        r = r.where('personal_ratings.best_rating < ?', max) if max
      elsif p[/^without:(\S+)/i]
        without = $1
        case without
          when 'image'
            r = r.where(:image_url => nil)
          when 'trailer'
            r = r.where(:trailer_url => nil)
        end
      else
        r = r.where('movies.title like ?', "%%%s%%" % p)
      end
    end

    if twins.size > 0
      r = r.joins("inner join user_votes on user_votes.movie_id = movies.id")
      twins.each do |username|
        twin = User.where(:username => username).first
        r = r.where("user_votes.user_id = ?", twin.id)
      end
    end

    if true
      date = nil
      case params[:years].to_s
        when 'year'
          date = 1.year.ago
        when 'three_years'
          date = 3.years.ago
        when 'five_years'
          date = 5.years.ago
        when 'decade'
          date = 10.years.ago
        when 'two_decades'
          date = 20.years.ago
        when 'all'
        else
          date = nil
          params[:years] = 'all'
      end
      r = r.where('year >= ?', date.year) if date
    end

    r = r.order(order)
    r = r.paginate :per_page => per_page, :page => params[:page]
    return r
  end

  def personal_rating(user)
    personal_ratings.find_by_user_id(user.id) if user
  end

  def user_vote(user)
    user_votes.find_by_user_id(user.id) if user
  end

  def self.get_min_max(param)
    max = param[/<\d+/]
    min = param[/>\d+/]

    min = min.delete(">").to_i if min
    max = max.delete("<").to_i if max

    return min, max
  end

  def copy_from_tmdb
    return if not ex_tmdb_movie

    self.title = ex_tmdb_movie.name.force_encoding('utf-8')
    self.description = ex_tmdb_movie.overview
    self.year = Time.local(ex_tmdb_movie.raw_data['released']).year if ex_tmdb_movie.raw_data['released']

    ex_tmdb_movie.raw_data['posters'].each do |poster|
      if poster['image']['size'] == 'cover'
        self.image_url = poster['image']['url']
      end
    end

    self.image_url = ex_tmdb_movie.raw_data['posters'][0]['image']['url'] if not self.image_url and ex_tmdb_movie.raw_data['posters'].size > 0

    tmdb_trailer = ex_tmdb_movie.raw_data['trailer']
    if tmdb_trailer
      ex_tmdb_movie.raw_data['trailer'][/v=(\w+)&?\S*/i]
      self.trailer_url = "http://www.youtube.com/embed/#{$1}" if $1
    end

    self.runtime = ex_tmdb_movie.raw_data['runtime']

    tmdb_genres = ex_tmdb_movie.raw_data['genres']
    if tmdb_genres and tmdb_genres.is_a?(Array)
      # remove old genres
      self.genres.each do |g|
        found = false
        tmdb_genres.each do |t|
          if t['name'] == g.name.force_encoding('utf-8')
            tmdb_genres.delete(t)
            found = true
            break
          end
        end
        self.genres.delete(g) if not found
      end

      # add new genres
      tmdb_genres.each do |g|
        params = {}
        params[:name] = g['name']
        params[:tmdb_url] = g['url']
        params[:tmdb_id] = g['id']

        genre = Genre.where("name = ?", g['name']).first
        genre = Genre.new(params) if not genre

        self.genres << genre
      end
    end


    tmdb_casts = ex_tmdb_movie.raw_data['cast']
    if tmdb_casts and tmdb_casts.is_a?(Array)
      #Remove old casts
      self.movie_persons.each do |c|
        found = false
        tmdb_casts.each do |t|
          if c.cast_id == 30 then
            10
          end

          if t['name'] == c.person.name.force_encoding('utf-8') and
              t['job'] == c.job.force_encoding('utf-8') and
              t['department'] ==  c.department.force_encoding('utf-8') and
              t['character'] == c.character.force_encoding('utf-8') and
              t['order'] == c.order and
              t['cast_id'] ==  c.cast_id
            tmdb_casts.delete(t)
            found = true
            break
          end
        end
       if not found
          self.movie_persons.delete(c) 
       end
      end

      #add new casts
      tmdb_casts.each do |c|
        # find person
        person = Person.where("tmdb_id = ?", c['id']).first

        if not person
          person = Person.new
          person.name = c['name']
          person.tmdb_id = c['id']
          person.save
        end

        cast = self.movie_persons.new
        cast.person = person
        cast.job = c['job']
        cast.department = c['department']
        cast.character = c['character']
        cast.order = c['order']
        cast.cast_id = c['cast_id']

        cast.save

      end

    end


    self.save
  end

  def to_param
    "#{id}-#{title.parameterize}"
  end

end
