class DashboardController < ApplicationController
  def show
    @excursions = DashboardFacade.user_excursions(current_user.id)
  rescue JSON::ParserError
    @excursions = []
    flash[:notice] = "We're sorry, we were unable to locate your excursions. Please try again later."
  end
end
