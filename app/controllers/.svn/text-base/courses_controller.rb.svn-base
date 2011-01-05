class CoursesController < ApplicationController
  # GET /courses
  # GET /courses.xml
  def index
    @courses = Course.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @courses }
    end
  end

  # GET /courses/1
  # GET /courses/1.xml
  def show
    @user = session[:user]
    #@course = Course.find(params[:id])
    sql_str = "select * from courses_max_version where org_id="+params[:id]
    @course = Course.find_by_sql(sql_str)[0]
    @instructor = User.find_by_id(@course.instructor_id)
    @timeslots = @course.timeslots

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @course }
    end
  end

  # GET /courses/new
  # GET /courses/new.xml
  def new
    if params[:instructor_id]
      @instructors = User.find_all_by_id(params[:instructor_id])
    else
      @instructors = User.find_all_by_type("Instructor");
    end

    @timeslots = Array.new
    @end_timeslots = Array.new
    t=Time.parse("8:00")
    while (t.hour < 20 || (t.hour==20 && t.min==0) )
      @timeslots.push(t.strftime("%H:%M"))
      t=t+(30*60)
    end
    @days = Array.new
    t=Time.parse("Nov 1,2010")
    7.times do
      @days.push({'name'=>t.strftime("%A") , 'id'=>t.wday})
      t=t+(24*60*60)
    end

    @course = Course.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @course }
    end
  end

  # GET /courses/1/edit
  def edit
    @course = Course.find(params[:id])
    @instructors = User.find_all_by_type("Instructor");
    @timeslots = Array.new
    @end_timeslots = Array.new
    t=Time.parse("8:00")
    while (t.hour < 20 || (t.hour==20 && t.min==0) )
      @timeslots.push(t.strftime("%H:%M"))
      t=t+(30*60)
    end
    @days = Array.new
    t=Time.parse("Nov 1,2010")
    7.times do
      @days.push({'name'=>t.strftime("%A") , 'id'=>t.wday})
      t=t+(24*60*60)
    end
  end

  # POST /courses
  # POST /courses.xml
  def create
    @course = Course.new(params[:course])
    @course.version_number=1
    num_timeslot=params[:num]
    num=num_timeslot["timeslot"].to_i
    num.times { |i|
      @timeslot = Timeslot.new(params["timeslot"+(i+1).to_s])
      @timeslot.version_number=1
      @course.timeslots.push(@timeslot)
    }

    respond_to do |format|
      if @course.save
        @course.update_attributes(:org_id => @course.id)
        format.html { redirect_to(@course, :notice => 'Course was successfully created.') }
        format.xml  { render :xml => @course, :status => :created, :location => @course }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @course.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /courses/1
  # PUT /courses/1.xml
  def update
    old_version = Course.find(params[:id])
    @course = Course.new(params[:course])
    @course.version_number=old_version.version_number+1
    @course.org_id=old_version.org_id
    num_timeslot=params[:num]
    num=num_timeslot["timeslot"].to_i
    num.times { |i|
      @timeslot = Timeslot.new(params["timeslot"+(i+1).to_s])
      @timeslot.version_number=old_version.version_number+1
      @course.timeslots.push(@timeslot)
    }
    #@course.id=old_version.id

    respond_to do |format|
      if @course.save
        format.html { redirect_to(@course, :notice => 'Course was successfully updated.') }
        format.xml  { render :xml => @course, :status => :created, :location => @course }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @course.errors, :status => :unprocessable_entity }
      end
    end


=begin
    @course = Course.find(params[:id])

    respond_to do |format|
      if @course.update_attributes(params[:course])
        format.html { redirect_to(@course, :notice => 'Course was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @course.errors, :status => :unprocessable_entity }
      end
    end
=end
  end

  # DELETE /courses/1
  # DELETE /courses/1.xml
  def destroy
    @course = Course.find(params[:id])
    @course.destroy

    respond_to do |format|
      format.html { redirect_to({:controller=>"home"}) }
      format.xml  { head :ok }
    end
  end
end
