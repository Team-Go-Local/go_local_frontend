class ExcursionsController < ApplicationController
  def new
  end

  def create
    params_2 = {
      title: params[:title],
      description: params[:description],
      location: params[:location]
    }
    #post "backend.herokuapp.com/users/#{current_user.id}/excursions?#{params_2.to_query}"
    flash[:notice] = "You have successfully created an Excursion!"
    redirect_to dashboard_path
  end
end
