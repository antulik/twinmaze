class AdminController < ApplicationController
  def show
    @tmdb_max = ExTmdbMovie.maximum("tmdb_id")
  end

  def update_tmdb
    r = Movie.search(params, current_user)
        
    r.each do |movie|
      TmdbJob.new.delay.update_tmdb_by_movie_id(movie.id)
    end

    redirect_to :back
  end

  def auto_sync_tmdb
    r = Movie.search(params, current_user)

    r.each do |movie|
      movie = Movie.find(movie.id)
      movie.copy_from_tmdb
    end
    redirect_to :back

  end

  def update_all_web_stats
    MovieJob.new.delay.update_votes_ratings_all

    redirect_to :back
  end

  def sync_youtube_trailer
    r = Movie.search(params, current_user)

    r.each do |movie|
      YoutubeWorker::Job.new.async_set_trailer_by_movie_id(movie)
    end

    redirect_to :back
  end


  def update_manual_tmdb

    return if not params[:from] or not params[:to]
    
    from = params[:from].to_i
    to = params[:to].to_i

    for x in from..to
      TmdbJob.new.delay.sync_to_tmdb(x)
    end

    redirect_to :back
  end

end
