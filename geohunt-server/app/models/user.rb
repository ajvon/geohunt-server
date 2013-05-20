class User < ActiveRecord::Base
  attr_accessible :username, :latitude, :longitude
  reverse_geocoded_by :latitude, :longitude
end
