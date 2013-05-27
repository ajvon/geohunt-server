#require 'geocoder'

class TrackingController < ApplicationController
    
    respond_to :json, :xml
    
    def move_user
        @user = User.find(params[:user_id])
        @user.latitude = params[:latitude]
        @user.longitude = params[:longitude]
        @user.save()
        
        @user.user_tracks.create(:date => DateTime.now, :latitude => @user.latitude, :longitude => @user.longitude)
        Token.update_all({:latitude => params[:latitude], :longitude => params[:longitude]}, {:user_id => @user})
        
        #@user.tokens.each do |token|
        #    token.latitude = params[:latitude]
        #    token.longitude = params[:longitude]
        #    token.save()
        #end
        
        respond_with(@user)
    end
    
    def show_users
        if gps_parametrized?
            respond_with(User.near([params[:latitude],params[:longitude]], 1000, { :units => :km })) 
        else
            respond_with(User.where(:latitude => params[:latitude_from]..params[:latitude_to], :longitude => params[:longitude_from]..params[:longitude_to]))
        end
    end
    
    def show_tokens
        if gps_parametrized?
            respond_with(Token.near([params[:latitude],params[:longitude]], 1000, { :units => :km }))
        else
            respond_with(Token.where(:latitude => params[:latitude_from]..params[:latitude_to], :longitude => params[:longitude_from]..params[:longitude_to]))
        end
    end
    
    def show_near_tokens
        respond_with(Token.near([params[:latitude],params[:longitude]], 1, { :units => :km }))
    end
    
    def show_user_track
        respond_with(User.find(params[:id]).user_tracks)
    end
    
    def show_token_track
        respond_with(Token.find(params[:id]).token_tracks) 
    end
    
    def take
        token = Token.find(params[:token_id])
        token.user = User.find(params[:user_id])
        token.save()
        
        respond_with(token)
    end

    def drop
        token = Token.find(params[:token_id])
        token.user = nil
        token.save()
        
        respond_with(token)
    end

    private
        def gps_parametrized?
            return params[:latitude].present? && params[:longitude].present? 
        end
    
end