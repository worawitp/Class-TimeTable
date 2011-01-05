class CreateTimeslots < ActiveRecord::Migration
  def self.up
    create_table :timeslots do |t|
      t.integer :course_id
      t.string :day
      t.time :starttime
      t.time :endtime

      t.timestamps
    end
  end

  def self.down
    drop_table :timeslots
  end
end
