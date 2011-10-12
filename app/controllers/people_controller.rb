class PeopleController < ApplicationController
  
  def show
    @person = Person.find(params[:id])

    @movies = @person.movies
  end

end
