class ExploreController < ApplicationController
  def index
    @excursions = ExcursionsFacade.list_all_excursions
  rescue JSON::ParserError
    @excursions = []
    flash[:notice] = "We're sorry, we were unable to locate the content you requested. Please try again later."
  end
end
