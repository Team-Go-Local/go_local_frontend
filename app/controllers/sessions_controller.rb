class SessionsController < ApplicationController
  def create
    user_info = request.env['omniauth.auth']
    name = user_info[:info][:name]
    uid = user_info[:uid]
    email = user_info[:info][:email]
    token = user_info[:credentials][:token]
    
    #found_user = User.find_or_create_by(uid: uid, email: email, token: token, name: name)

    found_user = User.find_or_create_by(name: name) do |user|
      user.uid = uid
      user.email = email
      user.token = token
      user.name = name
    end

    found_user.save
    session[:uid] = uid
    redirect_to dashboard_path
  end
end

# conn = Faraday.new(
#   url: 'https://www.googleapis.com/',
#   headers: {'Accept': 'application/json'}
# )
# require 'pry'; binding.pry

# response = conn.post('/login/oauth/access_token') do |req|
#   req.params['client_id'] = client_id
#   req.params['code'] = code
#   req.params['client_secret'] = client_secret
# end