class AddOrgIdToCourses < ActiveRecord::Migration
  def self.up
    add_column :courses, :org_id, :integer
  end

  def self.down
    remove_column :courses, :org_id
  end
end
