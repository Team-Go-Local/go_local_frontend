class ExploreController < ApplicationController
  def index
    @excursions = ExcursionsFacade.list_all_excursions
    @cities = ExcursionsFacade.city_list
  rescue JSON::ParserError
    @excursions = []
    @cities = []
    flash[:notice] = "We're sorry, we were unable to locate the content you requested. Please try again later."
  end
end 
