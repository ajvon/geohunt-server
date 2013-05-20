#require 'geocoder'

class TrackingController < ApplicationController
    
    respond_to :json, :xml
    
    def move_user
        @user = User.find(params[:user_id])
        @user.latitude = params[:latitude]
        @user.longitude = params[:longitude]
        @user.save()
        
        respond_with(@user)
    end
    
    def show_users
        #respond_with(Geocoder::Calculations.compass_point(355))
        respond_with(User.near([50.118762,14.492254], 1000, { :units => :km })) 
    end
    
end
