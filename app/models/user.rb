class User < ActiveRecord::Base
  attr_accessible :username, :latitude, :longitude
  
  reverse_geocoded_by :latitude, :longitude
  
  has_many :user_tracks
  has_many :tokens
  
end
