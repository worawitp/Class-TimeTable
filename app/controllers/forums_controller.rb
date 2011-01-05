class ForumsController < ApplicationController
  # GET /forums
  # GET /forums.xml
  def index
    @user = session[:user]
    @course = nil
    if params[:course_id]
      @forums = Forum.find_all_by_course_id(params[:course_id])
      sql_str = "select * from courses_max_version where org_id="+params[:course_id]
      courses = Course.find_by_sql(sql_str)
      @course=courses[0]
      #@course = Course.find_by_id(params[:course_id])
    else
      @forums = Forum.all
    end

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @forums }
    end
  end

  # GET /forums/1
  # GET /forums/1.xml
  def show
    @user = session[:user]
    @forum = Forum.find(params[:id])
    @topics = Topic.find_all_by_forum_id(@forum.id,:order => "updated_at desc")

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @forum }
    end
  end

  # GET /forums/new
  # GET /forums/new.xml
  def new
    @forum = Forum.new
    if params[:course_id]
      sql_str = "select * from courses_max_version where org_id="+params[:course_id]
      @courses = Course.find_by_sql(sql_str)
      #@course=courses[0]
      #@courses = Course.find_all_by_id(params[:course_id])
    else
      @courses = Course.all
    end
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @forum }
    end
  end

  # GET /forums/1/edit
  def edit
    @forum = Forum.find(params[:id])
    if params[:course_id]
      sql_str = "select * from courses_max_version where org_id="+params[:course_id]
      @courses = Course.find_by_sql(sql_str)
      #@course=courses[0]
      #@courses = Course.find_all_by_id(params[:course_id])
    else
      @courses = Course.all
    end
  end

  # POST /forums
  # POST /forums.xml
  def create
    @forum = Forum.new(params[:forum])

    respond_to do |format|
      if @forum.save
        format.html { redirect_to(@forum, :notice => 'Forum was successfully created.') }
        format.xml  { render :xml => @forum, :status => :created, :location => @forum }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @forum.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /forums/1
  # PUT /forums/1.xml
  def update
    @forum = Forum.find(params[:id])

    respond_to do |format|
      if @forum.update_attributes(params[:forum])
        format.html { redirect_to(@forum, :notice => 'Forum was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @forum.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /forums/1
  # DELETE /forums/1.xml
  def destroy
    @forum = Forum.find(params[:id])
    org_id = @forum.course_id
    @forum.destroy

    respond_to do |format|
      format.html { redirect_to(course_forums_url(org_id)) }
      format.xml  { head :ok }
    end
  end
end
