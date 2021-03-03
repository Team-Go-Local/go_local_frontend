class SessionsController < ApplicationController
  def create
    user_info = request.env['omniauth.auth']

    user = User.find_or_create_by(uid: user_info[:uid]) do |new_user|
      new_user.uid = user_info[:uid]
      new_user.email = user_info[:info][:email]
      new_user.token = user_info[:credentials][:token]
      new_user.name = user_info[:info][:name]
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
