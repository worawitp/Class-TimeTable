class CreateSurveychoices < ActiveRecord::Migration
  def self.up
    create_table :surveychoices do |t|
      t.integer :survey_id
      t.integer :choice_number
      t.string :content

      t.timestamps
    end
  end

  def self.down
    drop_table :surveychoices
  end
end
