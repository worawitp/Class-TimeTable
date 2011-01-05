class HomeController < ApplicationController

  require_role 'admin', :for => [:admin_index]
  before_filter :login_required
  
  def index
    @user = session[:user]
    if @user==nil
      redirect_to :controller => "sessions", :action => "new"
    end
    check_admin(@user)

    if @user.type.to_s == "Instructor"
      #@courses = Course.find_all_by_instructor_id(@user.id)
      sql_str = "select * from courses_max_version where instructor_id="+@user.id.to_s+" order by number"
      @courses = Course.find_by_sql(sql_str)
    elsif @user.type.to_s == "Student"
      #@courses = Course.all
      sql_str = "select * from courses_max_version order by number"
      @courses = Course.find_by_sql(sql_str)
      student_courses = StudentCourse.find_all_by_student_id(@user.id)
      @taken_courses=Array.new
      for student_course in student_courses do
        #course = Course.find_by_id(student_course.take_course_id)
        sql_str = "select * from courses_max_version where org_id="+student_course.take_course_id.to_s
        course = Course.find_by_sql(sql_str)
        if course.length > 0
          @taken_courses.push(course[0])
        end
      end
    end

  end

  def edit
    @title = "Edit user info"
    @user = session[:user]
     if @user==nil
      redirect_to :controller => "sessions", :action => "new"
    end
    if param_posted?(:user)
      attribute = params[:attribute]
      case attribute
        when "details"
          if @user.update_attributes( params[:user] )
            flash[:notice] = "User details updated."
            redirect_to :action => "index"
          end
        when "password"
          if @user.update_password(params[:user])
            flash[:notice] = "User password updated."
            redirect_to :action => "index"
          else
            flash[:notice] = "Unable to update password."
          end
      end
      params[:user].delete "password"
      params[:user].delete "current_password"
      params[:user].delete "password_confirmation"
    end
# For security purposes, never fill in password fields.
    @user.clear_password!

  end

  def admin_index
    @user=session[:user]
    @all_users=User.find(:all)
  end

  def check_admin(user)
    @admin_role = false
    if user==nil
      return
    end
    for role in user.roles
      if role.name == "admin"
        @admin_role = true
      end
    end
  end

  def drop_course
    @student_course = StudentCourse.find_by_sql("select * from student_courses where student_id="+params[:student_id]+
    " and take_course_id="+params[:course_id])
    @student_course[0].destroy

    respond_to do |format|
      format.html { redirect_to({:controller => "home"}) }
      format.xml  { head :ok }
    end

  end

  def all_students
    @course_id = params[:course_id]
    student_courses = StudentCourse.find_all_by_take_course_id(params[:course_id])
    @students = Array.new
    for student_course in student_courses
      student=Student.find_by_id(student_course.student_id)
      @students.push(student)
    end
    sql_str = "select * from courses_max_version where org_id=" + params[:course_id]
    courses = Course.find_by_sql(sql_str)
    @course = courses[0]
  end

  def all_distinct_courses
    @user=session[:user]

    @topic=Topic.new
    @course_id = params[:course_id]
    sql_str = "select distinct take_course_id from student_courses where student_id in (select student_id from student_courses where take_course_id="+params[:course_id]+")"
    @courses_id = StudentCourse.find_by_sql(sql_str)
    sql_str = "select * from courses_max_version where org_id in (select distinct take_course_id from student_courses where student_id in (select student_id from student_courses where take_course_id="+params[:course_id]+"))"
    @courses = Course.find_by_sql(sql_str)


    @timeslots=Array.new
    @courses.each do |course|
      #course = Course.find(params[:id])
      #@instructor = User.find_by_id(@course.instructor_id)
      timeslots = course.timeslots

      timeslots.each do |timeslot|
        @timeslots.push(timeslot)
      end
    end

    @timeslots2 = Array.new
    @end_timeslots = Array.new
    t=Time.parse("8:00")
    while (t.hour < 20 || (t.hour==20 && t.min==0) )
      @timeslots2.push(t.strftime("%H:%M"))
      t=t+(30*60)
    end
    @days = Array.new
    t=Time.parse("Nov 1,2010")
    7.times do
      @days.push({'name'=>t.strftime("%A") , 'id'=>t.wday})
      t=t+(24*60*60)
    end


  end

  def show_all_versions
    sql_str = "select * from courses where org_id="+params[:course_id]
    @courses = Course.find_all_by_org_id(params[:course_id], :order => "version_number")
  end
end
