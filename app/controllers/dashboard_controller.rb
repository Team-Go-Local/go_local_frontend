class DashboardController < ApplicationController
  def show
    @excursions = DashboardFacade.user_excursions(current_user.id)
  end
end
