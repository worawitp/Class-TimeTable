class CreateComments < ActiveRecord::Migration
  def self.up
    create_table :comments do |t|
      t.integer :topic_id
      t.integer :comment_number
      t.text :content
      t.integer :owner_id

      t.timestamps
    end
  end

  def self.down
    drop_table :comments
  end
end
