class StudentCoursesController < ApplicationController
  # GET /student_courses
  # GET /student_courses.xml
  def index
    @student_courses = StudentCourse.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @student_courses }
    end
  end

  # GET /student_courses/1
  # GET /student_courses/1.xml
  def show
    student_courses = StudentCourse.find_all_by_student_id(params[:student_id])

    @taken_courses=Array.new
    for student_course in student_courses do
      #course = Course.find_by_id(student_course.take_course_id)
      sql_str = "select * from courses_max_version where org_id="+student_course.take_course_id.to_s
      course = Course.find_by_sql(sql_str)
      if course.length > 0
        @taken_courses.push(course[0])
      end
    end

    @timeslots=Array.new
    @taken_courses.each do |course|
      #course = Course.find(params[:id])
      #@instructor = User.find_by_id(@course.instructor_id)
      timeslots = course.timeslots

      timeslots.each do |timeslot|
        @timeslots.push(timeslot)
      end
    end

    #@student_courses = StudentCourse.find_all_by_student_id(params[:student_id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @student_course }
    end
  end

  # GET /student_courses/new
  # GET /student_courses/new.xml
  def new
    @student_course = StudentCourse.new
    if params[:student_id]
      @students = Student.find_all_by_id(params[:student_id])
    else
      @students = Student.all
    end

    #@courses = Course.all
    sql_str = "select * from courses_max_version where course_id is not in (order by number"
    sql_str = "select * from courses_max_version where org_id not in (select take_course_id from student_courses where student_id="+params[:student_id]+")";
    @courses = Course.find_by_sql(sql_str)

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @student_course }
    end
  end

  # GET /student_courses/1/edit
  def edit
    @student_course = StudentCourse.find(params[:id])
    if params[:student_id]
      @students = Student.find_all_by_id(params[:student_id])
    else
      @students = Student.all
    end

    @courses = Course.all
  end

  # POST /student_courses
  # POST /student_courses.xml
  def create
    @student_course = StudentCourse.new(params[:student_course])
    @user=session[:user]

    respond_to do |format|
      if @student_course.save
        format.html { redirect_to({:controller => "student_courses", :action => "show", :student_id => @user.id}, :notice => 'The course was successfully registered.') }
        format.xml  { render :xml => @student_course, :status => :created, :location => @student_course }
      else
        flash[:error] = 'Error: could not register the course.'
        format.html { redirect_to({:controller => "student_courses", :action => "new", :student_id => @user.id }) }
        format.xml  { render :xml => @student_course.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /student_courses/1
  # PUT /student_courses/1.xml
  def update
    @student_course = StudentCourse.find(params[:id])

    respond_to do |format|
      if @student_course.update_attributes(params[:student_course])
        format.html { redirect_to(@student_course, :notice => 'StudentCourse was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @student_course.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /student_courses/1
  # DELETE /student_courses/1.xml
  def destroy
    @student_course = StudentCourse.find(params[:id])
    @student_course.destroy

    respond_to do |format|
      format.html { redirect_to(student_courses_url) }
      format.xml  { head :ok }
    end
  end
end
