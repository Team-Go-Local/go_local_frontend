class SessionsController < ApplicationController
  def create
    user_info = request.env['omniauth.auth']
    name = user_info[:info][:name]
    uid = user_info[:uid]
    email = user_info[:info][:email]
    token = user_info[:credentials][:token]
    
    #found_user = User.find_or_create_by(uid: uid, email: email, token: token, name: name)
    require 'pry'; binding.pry
    found_user = User.find_or_create_by(uid: uid) do |user|
      user.uid = uid
      user.email = email
      user.token = token
      user.name = name
    end

    session[:uid] = uid
    # Only send this request IF we created a user in this action
    # If we Found a user, we will NOT send this post request
    # post "backend.herokuapp.com/api/v1/users/#{found_user.id}"
    redirect_to dashboard_path
  end
  
  def destroy
    session.delete(:uid)
    redirect_to root_path
  end
end