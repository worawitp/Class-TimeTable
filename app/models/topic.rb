class Topic < ActiveRecord::Base
  has_many :comments
  belongs_to :forum
  belongs_to :user
  has_one :survey
end
