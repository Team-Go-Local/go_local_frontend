class SessionsController < ApplicationController
  def create
    user_info = request.env['omniauth.auth']
    name = user_info[:info][:name]
    uid = user_info[:uid]
    email = user_info[:info][:email]
    token = user_info[:credentials][:token]

    if User.exists?(uid: uid)
      user = User.find_by(uid: uid)
    else
      user = User.create(name: name, uid: uid, email: email, token: token)
      Faraday.post("https://go-local-be.herokuapp.com/api/v1/users/#{user.id}")
    end

    session[:id] = user.id
    redirect_to dashboard_path
  end

  def destroy
    session.delete(:id)
    redirect_to root_path
  end
end
