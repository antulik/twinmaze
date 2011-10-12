class MovieListItemsController < ApplicationController
  # GET /movie_list_items
  # GET /movie_list_items.xml
  def index
    @movie_list_items = MovieListItem.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml { render :xml => @movie_list_items }
    end
  end

  # GET /movie_list_items/1
  # GET /movie_list_items/1.xml
  def show
    @movie_list_item = MovieListItem.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml { render :xml => @movie_list_item }
    end
  end

  # GET /movie_list_items/new
  # GET /movie_list_items/new.xml
  def new
    @movie_list_item = MovieListItem.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml { render :xml => @movie_list_item }
    end
  end

  # GET /movie_list_items/1/edit
  def edit
    @movie_list_item = MovieListItem.find(params[:id])
  end

  # POST /movie_list_items
  # POST /movie_list_items.xml
  def create
    @movie_list_item = MovieListItem.new(params[:movie_list_item])

    respond_to do |format|
      if @movie_list_item.save
        format.html { redirect_to(@movie_list_item, :notice => 'Movie list item was successfully created.') }
        format.xml { render :xml => @movie_list_item, :status => :created, :location => @movie_list_item }
      else
        format.html { render :action => "new" }
        format.xml { render :xml => @movie_list_item.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /movie_list_items/1
  # PUT /movie_list_items/1.xml
  def update
    @movie_list_item = MovieListItem.find(params[:id])

    respond_to do |format|
      if @movie_list_item.update_attributes(params[:movie_list_item])
        format.html { redirect_to(@movie_list_item, :notice => 'Movie list item was successfully updated.') }
        format.xml { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml { render :xml => @movie_list_item.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /movie_list_items/1
  # DELETE /movie_list_items/1.xml
  def destroy
    @movie_list_item = MovieListItem.find(params[:id])
    @movie_list_item.destroy

    respond_to do |format|
      format.html { redirect_to(movie_list_items_url) }
      format.xml { head :ok }
    end
  end

end
