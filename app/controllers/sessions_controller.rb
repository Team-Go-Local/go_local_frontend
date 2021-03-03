class SessionsController < ApplicationController
  def create
    user_info = request.env['omniauth.auth']
    name = user_info[:info][:name]
    uid = user_info[:uid]
    email = user_info[:info][:email]
    token = user_info[:credentials][:token]

    user = User.find_or_create_by(uid: uid) do |new_user|
      new_user.uid = uid
      new_user.email = email
      new_user.token = token
      new_user.name = name
      Faraday.post("https://tranquil-refuge-53915.herokuapp.com/api/v1/users/#{new_user.id}")
    end

    session[:id] = user.id
    redirect_to dashboard_path
  end

  def destroy
    session.delete(:id)
    redirect_to root_path
  end
end
