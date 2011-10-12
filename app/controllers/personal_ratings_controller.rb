class PersonalRatingsController < ApplicationController
  # GET /personal_ratings
  # GET /personal_ratings.xml
  def index
    @personal_ratings = PersonalRating.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @personal_ratings }
    end
  end

  # GET /personal_ratings/1
  # GET /personal_ratings/1.xml
  def show
    @personal_rating = PersonalRating.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @personal_rating }
    end
  end

  # GET /personal_ratings/new
  # GET /personal_ratings/new.xml
  def new
    @personal_rating = PersonalRating.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @personal_rating }
    end
  end

  # GET /personal_ratings/1/edit
  def edit
    @personal_rating = PersonalRating.find(params[:id])
  end

  # POST /personal_ratings
  # POST /personal_ratings.xml
  def create
    @personal_rating = PersonalRating.new(params[:personal_rating])

    respond_to do |format|
      if @personal_rating.save
        format.html { redirect_to(@personal_rating, :notice => 'Personal rating was successfully created.') }
        format.xml  { render :xml => @personal_rating, :status => :created, :location => @personal_rating }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @personal_rating.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /personal_ratings/1
  # PUT /personal_ratings/1.xml
  def update
    @personal_rating = PersonalRating.find(params[:id])

    respond_to do |format|
      if @personal_rating.update_attributes(params[:personal_rating])
        format.html { redirect_to(@personal_rating, :notice => 'Personal rating was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @personal_rating.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /personal_ratings/1
  # DELETE /personal_ratings/1.xml
  def destroy
    @personal_rating = PersonalRating.find(params[:id])
    @personal_rating.destroy

    respond_to do |format|
      format.html { redirect_to(personal_ratings_url) }
      format.xml  { head :ok }
    end
  end
end
