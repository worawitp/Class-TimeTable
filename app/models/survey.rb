class Survey < ActiveRecord::Base
  belongs_to :topic
  has_many :surveychoices
end
