class StudentCourse < ActiveRecord::Base
  belongs_to :student
  belongs_to :course

  validates_presence_of :student_id, :message => "Please enter valid student_id"
  validates_presence_of :take_course_id, :message => "Please enter valid courses_id"
end
