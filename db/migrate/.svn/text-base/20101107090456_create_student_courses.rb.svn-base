class CreateStudentCourses < ActiveRecord::Migration
  def self.up
    create_table :student_courses do |t|
      t.integer :student_id
      t.integer :take_course_id

      t.timestamps
    end
  end

  def self.down
    drop_table :student_courses
  end
end
