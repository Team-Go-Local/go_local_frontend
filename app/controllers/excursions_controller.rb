class ExcursionsController < ApplicationController
  def new
    @excursion = Excursion.new({ attributes: {} })
  end

  def show
    @excursion = ExcursionsFacade.get_excursion(params[:id])
  end

  def create
    if missing_params.present?
      @excursion = Excursion.new({ attributes: excursion_params })
      flash.now[:notice] = missing_params * "\n"
      render :new, obj: @excursion
    else
      flash[:notice] = ExcursionsFacade.create_excursion(excursion_params.merge({ user_id: current_user.id }))
      redirect_to dashboard_path
    end
  end

  def edit
    @excursion = ExcursionsFacade.edit_excursion(params[:id])
  end

  def update
    if missing_params.present?
      @excursion = Excursion.new({ id: params[:id], attributes: excursion_params })
      flash.now[:notice] = missing_params * "\n"
      render :edit, obj: @excursion
    else
      flash[:notice] = ExcursionsFacade.update_excursion(excursion_params, current_user.id, params[:id])
      redirect_to dashboard_path
    end
  end

  def destroy
    flash[:notice] = ExcursionsFacade.destroy_excursion(current_user.id, params[:id])
    redirect_to dashboard_path
  end

  def favorite
    ExcursionsFacade.favorite_excursion(current_user.id, params[:id])
  end

  private

  def excursion_params
    params.permit(:title, :description, :location, :place_id, :coordinates)
  end

  def missing_params
    keys = excursion_params.except(:place_id, :coordinates).select { |_, v| v.blank? }.keys
    keys.map do |param|
      "#{param.capitalize} can't be blank."
    end
  end
end
