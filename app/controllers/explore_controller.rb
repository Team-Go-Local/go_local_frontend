class ExploreController < ApplicationController
  def index
    @excursions = ExcursionsFacade.list_all_excursions
    @cities = ExcursionsFacade.city_list
  rescue JSON::ParserError
    @excursions = []
    @cities = []
    flash.now[:notice] = "We're sorry, we were unable to locate the content you requested. Please try again later."
  end

  def search
    @excursions = ExcursionsFacade.list_all_excursions(params[:city])
    @cities = ExcursionsFacade.city_list
  rescue JSON::ParserError
    @excursions = []
    @cities = []
    flash.now[:notice] = "We're sorry, we were unable to locate the content you requested. Please try again later."
  ensure
    render :index
  end
end
