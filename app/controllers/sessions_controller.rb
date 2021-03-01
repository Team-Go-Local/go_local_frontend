class SessionsController < ApplicationController
  def create
    user_info = request.env['omniauth.auth']
    name = user_info[:info][:name]
    uid = user_info[:uid]
    email = user_info[:info][:email]
    token = user_info[:credentials][:token]

    User.find_or_create_by(uid: uid) do |user|
      user.uid = uid
      user.email = email
      user.token = token
      user.name = name
    end

    session[:id] = user.id
    redirect_to dashboard_path
  end

  def destroy
    session.delete(:uid)
    redirect_to root_path
  end
end
