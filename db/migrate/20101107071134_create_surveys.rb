class CreateSurveys < ActiveRecord::Migration
  def self.up
    create_table :surveys do |t|
      t.integer :topic_id
      t.datetime :close_datetime

      t.timestamps
    end
  end

  def self.down
    drop_table :surveys
  end
end
