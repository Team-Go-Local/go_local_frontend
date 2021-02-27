class ExcursionsController < ApplicationController
  def new
  end

  def create
    post "backend.herokuapp.com/excursions/create/#{params}"
    params = {
      title: params[:title],
      description: params[:description],
      location: params[:location]
    }
  end
end
