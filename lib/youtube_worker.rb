module YoutubeWorker
  # enter your yourtube key here
  KEY = ""

  class Job

    def search_trailer(name)
      id_by_name("#{name} trailer")
    end

    def id_by_name(name)

      client = YouTubeIt::Client.new(:dev_key => KEY)
      query = client.videos_by(:query => name, :per_page => 2)

      if query.videos.size > 0
        video = query.videos[0]
        video.video_id.scan(/video:(\S+):?/i)
        $1
      end
    end

    def set_trailer_by_movie_id(movie_id)
      movie = Movie.find(movie_id)
      return if not movie

      youtube_id = search_trailer(movie.title)
      movie.trailer_url = "http://www.youtube.com/embed/#{youtube_id}"
      movie.save
    end

    def async_set_trailer_by_movie_id(movie_id)
      set_trailer_by_movie_id(movie_id)
    end

    handle_asynchronously :async_set_trailer_by_movie_id, :priority => 10
#    :run_at => Proc.new { 5.minutes.from_now }
  end
  
end