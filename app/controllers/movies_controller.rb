class MoviesController < ApplicationController
  
  before_filter :login_required
  
  # GET /movies
  # GET /movies.xml
  def index
    @movies = Movie.all
    @imdb_base_url = "http://www.imdb.com/title/"

    require 'rubygems'
    require 'tmdb_party'
    @tmdb = TMDBParty::Base.new('b81cd5766890f20ece59ed3ad4573173')

    @results = nil
    @original_img = "none"
    @thumb_img = "none"
#puts "GETS TO THIS POINT 1"
#puts params[:search]
    if params[:search]
#puts "GETS TO THIS POINT 1.1"
      @results = @tmdb.search(params[:search])
#puts "GETS TO THIS POINT 1.2"
    end
#puts "GETS TO THIS POINT 2"
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @movies }
    end   
        
  end

  # GET /movies/1
  # GET /movies/1.xml
  def show
    @movie = Movie.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @movie }
    end
  end

  # GET /movies/new
  # GET /movies/new.xml
  def new
    @movie = Movie.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @movie }
    end
  end

  # GET /movies/1/edit
  def edit
    @movie = Movie.find(params[:id])
  end

  # POST /movies
  # POST /movies.xml
  def create
    @movie = Movie.new(params[:movie])

    respond_to do |format|
      if @movie.save
        flash[:notice] = 'Movie was successfully created.'
        format.html { redirect_to(@movie) }
        format.xml  { render :xml => @movie, :status => :created, :location => @movie }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @movie.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /movies/1
  # PUT /movies/1.xml
  def update
    @movie = Movie.find(params[:id])

    respond_to do |format|
      if @movie.update_attributes(params[:movie])
        flash[:notice] = 'Movie was successfully updated.'
        format.html { redirect_to(@movie) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @movie.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /movies/1
  # DELETE /movies/1.xml
  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy

    respond_to do |format|
      format.html { redirect_to(movies_url) }
      format.xml  { head :ok }
    end
  end
  
  def update_movies_and_watched
    
    successful_save = true
    
    params[:seen_movies].each do |movie_details|
      
      details = movie_details.split("@@")
        
      #name
      #imdb_id
      #released
      #overview
      #@original_img
      #@thumb_img
      
      theTime = Time.now
      
      @watched = Watched.new({:user_id => User.find_by_username(current_user.username).id, :imdb_id => details[1], :created_at => theTime, :updated_at => theTime})
      
      if !Movie.find_by_imdb_id(details[1])
        
          @movie = Movie.new({:title => details[0], :imdb_id => details[1], :released => details[2], :overview => details[3], :original_img_url => details[4], :thumb_img_url => details[5], :created_at => theTime, :updated_at => theTime})
        
          if !@movie.save || !@watched.save
            successful_save = false
          end
            #flash[:notice] = 'Successfully added to watched list.'
            #format.html { redirect_to(watcheds_path) }
            #format.xml  { render :xml => @movie, :status => :created, :location => @movie }
          #else
          #  flash[:notice] = 'There was an error recording the movie(s) you\'ve watched.  Please try again.'
          #  format.html { render :action => "index" }
          #  format.xml  { render :xml => @movie.errors, :status => :unprocessable_entity }
          #end
        
      else
        
          #respond_to do |format|
          if !@watched.save
            successful_save = false
          end
          
            #flash[:notice] = 'Successfully added to watched list.'
            #format.html { redirect_to(watcheds_path) }
            #format.xml  { render :xml => @movie, :status => :created, :location => @movie }
          #else
            #flash[:notice] = 'There was an error recording the movie(s) you\'ve watched.  Please try again.'
            #format.html { render :action => "index" }
            #format.xml  { render :xml => @movie.errors, :status => :unprocessable_entity }
          #end
        #end
          
      end
      
    end
    
    if successful_save
        flash[:notice] = 'Successfully added to watched list.'
        redirect_to(watcheds_path)
    else
        flash[:notice] = 'There was an error recording the movie(s) you\'ve watched.  Please try again.'
        render :action => "index"
    end
    
  end
  
end
