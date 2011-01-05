class Course < ActiveRecord::Base
  has_many :student_course
  has_many :students, :through => :student_course
  belongs_to :instructor
  has_many :timeslots
  has_many :forums
end
