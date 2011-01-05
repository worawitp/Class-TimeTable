class Room < ActiveRecord::Base
  has_many :timeslots
end
