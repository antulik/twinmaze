class UserTwinsController < ApplicationController
  # GET /user_twins
  # GET /user_twins.xml
  def index
    @user_twins = UserTwin.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @user_twins }
    end
  end

  # GET /user_twins/1
  # GET /user_twins/1.xml
  def show
    @user_twin = UserTwin.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @user_twin }
    end
  end

  # GET /user_twins/new
  # GET /user_twins/new.xml
  def new
    @user_twin = UserTwin.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @user_twin }
    end
  end

  # GET /user_twins/1/edit
  def edit
    @user_twin = UserTwin.find(params[:id])
  end

  # POST /user_twins
  # POST /user_twins.xml
  def create
    @user_twin = UserTwin.new(params[:user_twin])

    respond_to do |format|
      if @user_twin.save
        format.html { redirect_to(@user_twin, :notice => 'User twin was successfully created.') }
        format.xml  { render :xml => @user_twin, :status => :created, :location => @user_twin }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @user_twin.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /user_twins/1
  # PUT /user_twins/1.xml
  def update
    @user_twin = UserTwin.find(params[:id])

    respond_to do |format|
      if @user_twin.update_attributes(params[:user_twin])
        format.html { redirect_to(@user_twin, :notice => 'User twin was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @user_twin.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /user_twins/1
  # DELETE /user_twins/1.xml
  def destroy
    @user_twin = UserTwin.find(params[:id])
    @user_twin.destroy

    respond_to do |format|
      format.html { redirect_to(user_twins_url) }
      format.xml  { head :ok }
    end
  end
end
