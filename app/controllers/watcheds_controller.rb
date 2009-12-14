class WatchedsController < ApplicationController
  
  before_filter :login_required
  
  # GET /watcheds
  # GET /watcheds.xml
  def index
    @watcheds = Watched.all
    @imdb_base_url = "http://www.imdb.com/title/"
    @current_user_id = User.find_by_username(current_user.username).id

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @watcheds }
    end
  end

  # GET /watcheds/1
  # GET /watcheds/1.xml
  def show
    @watched = Watched.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @watched }
    end
  end

  # GET /watcheds/new
  # GET /watcheds/new.xml
  def new
    @watched = Watched.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @watched }
    end
  end

  # GET /watcheds/1/edit
  def edit
    @watched = Watched.find(params[:id])
  end

  # POST /watcheds
  # POST /watcheds.xml
  def create
    @watched = Watched.new(params[:watched])

    respond_to do |format|
      if @watched.save
        flash[:notice] = 'Watched was successfully created.'
        format.html { redirect_to(@watched) }
        format.xml  { render :xml => @watched, :status => :created, :location => @watched }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @watched.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /watcheds/1
  # PUT /watcheds/1.xml
  def update
    @watched = Watched.find(params[:id])

    respond_to do |format|
      if @watched.update_attributes(params[:watched])
        flash[:notice] = 'Watched was successfully updated.'
        format.html { redirect_to(@watched) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @watched.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /watcheds/1
  # DELETE /watcheds/1.xml
  def destroy
    @watched = Watched.find(params[:id])
    @watched.destroy

    respond_to do |format|
      format.html { redirect_to(watcheds_url) }
      format.xml  { head :ok }
    end
  end
end
