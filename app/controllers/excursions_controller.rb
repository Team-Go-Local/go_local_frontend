class ExcursionsController < ApplicationController
  def new; end

  def create
    ExcursionsFacade.create_excursion(excursion_params.merge({user_id: current_user.id}))
    flash[:notice] = "You have successfully created an Excursion!"
    redirect_to dashboard_path
  end

  def edit
    @excursion = ExcursionsFacade.get_excursion(params[:id])
  end

  def update
    ExcursionsFacade.update_excursion(excursion_params, current_user.id, params[:id])
    flash[:notice] = 'You have successfully edited an Excursion!'
    redirect_to dashboard_path
  end

  private

  def excursion_params
    params.permit(:title, :description, :location, :place_id)
  end
end
