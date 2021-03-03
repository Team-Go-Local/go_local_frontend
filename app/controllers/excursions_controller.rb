class ExcursionsController < ApplicationController
  def new
    @excursion = Excursion.new({ attributes: {} })
  end

  def create
    if missing_params.present?
      @excursion = Excursion.new({ attributes: excursion_params })
      flash[:notice] = missing_params*"\n"
      render :new, obj: @excursion
    else
      response = ExcursionsFacade.create_excursion(excursion_params.merge({user_id: current_user.id}))
      flash[:notice] = response
      redirect_to dashboard_path
    end
  end

  def edit
    @excursion = ExcursionsFacade.get_excursion(params[:id])
  end

  def update
    ExcursionsFacade.update_excursion(excursion_params, current_user.id, params[:id])
    flash[:notice] = 'You have successfully edited an Excursion!'
    redirect_to dashboard_path
  end

  def destroy
    ExcursionsFacade.destroy_excursion(current_user.id, params[:id])
    flash[:notice] = 'You have successfully deleted an Excursion!'
    redirect_to dashboard_path
  end

  private

  def excursion_params
    params.permit(:title, :description, :location, :place_id)
  end

  def missing_params
    keys = excursion_params.except(:place_id).select { |_,v| v.blank? }.keys
    keys.map do |param|
      param.capitalize + ' can\'t be blank.'
    end
  end
end
