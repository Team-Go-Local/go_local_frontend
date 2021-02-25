class SessionsController < ApplicationController
  def create
    user_info = request.env['omniauth.auth']
    uid = user_info[:uid]
    email = user_info[:info][:email]
    token = user_info[:credentials][:token]
    
    found_user = User.find_or_create_by(uid: uid)
    found_user.save
    session[:uid] = uid
    
    redirect_to dashboard_path(found_user)

    # client_id = ENV['GOOGLE_CLIENT_ID']
    # client_secret = ENV['GOOGLE_CLIENT_SECRET']
    # code = params[:code]
    # conn = Faraday.new(
    #   url: 'https://www.googleapis.com/',
    #   headers: {'Accept': 'application/json'}
    # )

    
  end
end
