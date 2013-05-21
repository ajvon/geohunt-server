#require 'geocoder'

class TrackingController < ApplicationController
    
    respond_to :json, :xml
    
    def move_user
        @user = User.find(params[:user_id])
        @user.latitude = params[:latitude]
        @user.longitude = params[:longitude]
        @user.save()
        
        @user.user_tracks.create(:date => DateTime.now, :latitude => @user.latitude, :longitude => @user.longitude)
        
        respond_with(@user)
    end
    
    def show_users
        respond_with(User.near([50.118762,14.492254], 1000, { :units => :km })) 
    end
    
    def show_user_track
        respond_with(User.find(params[:id]).user_tracks)
    end
    
end
