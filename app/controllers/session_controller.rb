class SessionController < ApplicationController
  def new
    
  end

  def create
    auth = request.env['omniauth.auth']
     if auth and params[:provider]
        @authhash = Hash.new # {"email" => '', "name" => '', "uid" =>'',  "provider" =>''}
        @authhash[:provider] = auth['provider'] or ''
          if params[:provider] == 'facebook'
            @authhash[:email] = auth['extra']['raw_info']['email'] or ''
            @authhash[:first_name] =  auth['extra']['raw_info']['first_name'] or ''
            @authhash[:last_name] =  auth['extra']['raw_info']['last_name'] or ''
            @authhash[:name] =  auth['extra']['raw_info']['last_name'] or ''
            @authhash[:gender] =  auth['extra']['raw_info']['gender'] or ''
            @authhash[:name] =  auth['extra']['raw_info']['name'] or ''
            @authhash[:facebook_id] =  auth['extra']['raw_info']['id'].to_s or ''
            @authhash[:profile_picture] =  auth['info']['image'].to_s or ''

            @authhash[:fb_token] = auth['credentials']['token'] or nil
          elsif ['google'].index(params[:provider]) != nil
            @authhash[:email] =  auth['info']['email'] or ''
            @authhash[:name] = auth['info']['name'] or ''
            @authhash[:uid] = auth['uid'].to_s or ''
          else
         # TODO: message that it is not supported
          render root_url
          return
          end
          @fb_user  = User.where(:facebook_id => @authhash[:facebook_id]).first
          if @fb_user.present?
            @fb_user.update_attributes(:fb_token =>@authhash[:fb_token], :first_name => @authhash[:first_name],:last_name => @authhash[:last_name],:gender => @authhash[:gender],:email=>@authhash[:email],:name => @authhash[:name],:facebook_id=>@authhash[:facebook_id],:provider=>@authhash[:provider])
            if @fb_user.save
              session[:facebook_id] = @fb_user.facebook_id
              session[:user_id] = @fb_user.id
              redirect_to welcome_page_path(session[:user_id])
            end
          else
            @user = User.create
            @user.update_attributes(:fb_token =>@authhash[:fb_token], :first_name => @authhash[:first_name],:last_name => @authhash[:last_name],:gender => @authhash[:gender],:email=>@authhash[:email],:name => @authhash[:name],:facebook_id=>@authhash[:facebook_id],:provider=>@authhash[:provider])
            if @user.save
              session[:facebook_id] = @authhash[:facebook_id]
              session[:user_id] = @user.id
              redirect_to welcome_page_path(session[:user_id])
            end
            puts"%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%else condision #{@fb_user.inspect}"
          end
         
    puts"%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%#{@authhash.inspect}"
  end
end
end
