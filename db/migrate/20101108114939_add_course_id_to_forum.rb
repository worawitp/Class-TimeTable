class AddCourseIdToForum < ActiveRecord::Migration
  def self.up
    add_column :forums, :course_id, :integer
  end

  def self.down
    remove_column :forums, :course_id
  end
end
