class ExcursionsController < ApplicationController
  def new; end

  def create
    ExcursionsFacade.create_excursion(excursion_params, current_user.id)
    flash[:notice] = "You have successfully created an Excursion!"
    redirect_to dashboard_path
  end

  def edit; end

  def update
    ExcursionsFacade.updated_excursions(excursion_params.merge({user_id: current_user.id}))
    # {
    #   title: params[:title],
    #   description: params[:description],
    #   location: params[:location]
    # }
    # patch "backend.herokuapp.com/users/#{current_user.id}/excursions/:excursion_id?#{params_2.to_query}""
    flash[:notice] = 'You have successfully edited an Excursion!'
    redirect_to dashboard_path
  end

  private

  def excursion_params
    params.permit(:title, :description, :location, :place_id)
  end
end
