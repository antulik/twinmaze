class TmdbJob
  def set_key
    Tmdb.api_key = ""
  end

  def update_tmdb_by_movie_id(movie_id)
    movie = Movie.find(movie_id)

    if movie.tmdb_id
      update_by_tmdb_id(movie.tmdb_id)
    elsif movie.imdb_id
      tm = update_by_imdb_id(movie.imdb_id)
      movie.tmdb_id = tm.id if tm
    end

    movie.copy_from_tmdb
  end

  def update_by_imdb_id(imdb_id)
    set_key
    tmdb_movie = TmdbMovie.find(:imdb => imdb_id, :limit => 1)
    save_data(tmdb_movie)
  end

  def update_by_tmdb_id(tmdb_id)
    set_key
    tmdb_movie = TmdbMovie.find(:id => tmdb_id, :limit => 1)
    save_data(tmdb_movie)
  end

  def save_data(tmdb_movie)
    return nil if not tmdb_movie or tmdb_movie.empty?

    m = ExTmdbMovie.where(:tmdb_id => tmdb_movie.id).first
    params = extract_hash_params(tmdb_movie) || {}
    if m and params
      m.update_attributes(params)
    else
      m = ExTmdbMovie.new(params)
      m.save
    end
    tmdb_movie
  end

  def sync_to_tmdb(tmdb_id)
    update_by_tmdb_id(tmdb_id)

    movie = Movie.find_by_tmdb_id(tmdb_id)
    if not movie then
      movie = Movie.new
      movie.tmdb_id = tmdb_id
    end

    movie.copy_from_tmdb
  end

  private

  def extract_hash_params(tmdb_movie)
    params = {}
    params[:tmdb_id] = tmdb_movie.id
    params[:imdb_id] = tmdb_movie.imdb_id
    params[:name] = tmdb_movie.name
    params[:popularity] = tmdb_movie.popularity
    params[:translated] = tmdb_movie.translated
    params[:adult] = tmdb_movie.adult
    params[:language] = tmdb_movie.language
    params[:original_name] = tmdb_movie.original_name
    params[:name] = tmdb_movie.name
    params[:alternative_name] = tmdb_movie.alternative_name
    params[:movie_type] = tmdb_movie.movie_type
    params[:url] = tmdb_movie.url
    params[:votes] = tmdb_movie.votes
    params[:rating] = tmdb_movie.rating
    params[:status] = tmdb_movie.status
    params[:tagline] = tmdb_movie.tagline
    params[:certification] = tmdb_movie.certification
    params[:overview] = tmdb_movie.overview
    params[:released] = tmdb_movie.released
    params[:runtime] = tmdb_movie.runtime
    params[:budget] = tmdb_movie.budget
    params[:revenue] = tmdb_movie.revenue
    params[:homepage] = tmdb_movie.homepage
    params[:trailer] = tmdb_movie.trailer
    params[:version] = tmdb_movie.version
    params[:last_modified_at] = tmdb_movie.last_modified_at

    params[:raw_data] = tmdb_movie.raw_data

    params
  end

  def sync_tmdb(m, tm)
    params = extract_hash_params(tm) || {}
    if m and tm and params
      m.update_attributes(params)
    else
      m = Movie.new(params)
      m.save
    end

    sync_genres(m, tm)
    sync_people(m, tm)
    sync_images(m, tm)
    sync_countries(m, tm)
    sync_languages(m, tm)

    m.image_url = m.cover_movie_images.tmdb_url if m.cover_movie_images
    m.save
  end

  def sync_genres(movie, tmdb_movie)
    # remove old genres
    movie.genres.each do |g|
      found = false
      tmdb_movie.genres.each do |t|
        if t.name = g.name
          tmdb_movie.genres.delete(t)
          found = true
          break
        end
      end
      movie.genres.delete(g) if not found
    end

    # add new genres
    tmdb_movie.genres.each do |g|
      params = {}
      params[:name] = g.name
      params[:tmdb_url] = g.url
      params[:tmdb_id] = g.id

      genre = Genre.where("tmdb_id = ?", g.id).first
      genre = Genre.new(params) if not genre

      movie.genres << genre
    end
  end

  def sync_people(movie, tmdb_movie)
    # remove old people
    movie.movie_persons.each do |mp|
      found = false
      tmdb_movie.cast.each do |c|
        if mp.person.tmdb_id = c.id and
            mp.job = c.job and
            mp.department = c.department and
            mp.character = c.character
          # This is the cast
          tmdb_movie.cast.delete(c)
          found = true
          break
        end
      end
      movie.movie_persons.delete(mp) if not found
    end

    # add new people
    tmdb_movie.cast.each do |mp|
      params = {}
      params[:job] = mp.job
      params[:department] = mp.department
      params[:character] = mp.character
      params[:order] = mp.order
      params[:cast_id] = mp.cast_id

      person_params = {}
      person_params[:name] = mp.name
      person_params[:tmdb_url] = mp.url
      person_params[:tmdb_id] = mp.id

      person = Person.where("tmdb_id = ?", mp.id).first
      person = Person.new(person_params) if not person

      lmp = MoviePerson.new(params)
      lmp.movie = movie
      lmp.person = person

      movie.movie_persons << lmp
    end
  end

  def sync_countries(movie, tmdb_movie)
    countries = Array.new
    tmdb_movie.countries.each do |c|
      params = {}
      params[:code] = c.code
      params[:name] = c.name
      params[:tmdb_url] = c.url
      countries << params
    end

    movie.tmdb_countries = countries
  end

  def sync_languages(movie, tmdb_movie)
    languages = Array.new
    tmdb_movie.languages_spoken.each do |c|
      params = {}
      params[:code] = c.code
      params[:name] = c.name
      params[:native_name] = c.native_name
      languages << params
    end

    movie.tmdb_languages = languages
  end

  def sync_images(movie, tmdb_movie)
    images = tmdb_movie.posters + tmdb_movie.backdrops

    # remove old
    movie.movie_images.each do |mi|
      found = false
      images.each do |i|
        if i.id = mi.tmdb_id and
            i.url = mi.tmdb_url and
            i.type = mi.tmdb_type and
            i.size = mi.size and
            i.height = mi.height and
            i.width = mi.width
          # This is the cast
          images.delete(i)
          found = true
          break
        end
      end
      movie.movie_images.delete(mi) if not found
    end

    # add new posters
    images.each do |p|
      params = {}
      params[:tmdb_type] = p.type
      params[:size] = p.size
      params[:height] = p.height
      params[:width] = p.width
      params[:tmdb_url] = p.url
      params[:tmdb_id] = p.id

      mi = MovieImage.new(params)

      movie.movie_images << mi
    end
  end


#  handle_asynchronously :update_tmdb_by_movie_id, :priority => 0
end