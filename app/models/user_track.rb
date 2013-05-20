class UserTrack < ActiveRecord::Base
  belongs_to :user
  attr_accessible :date, :latitude, :longitude
end
