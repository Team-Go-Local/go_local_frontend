class ExploreController < ApplicationController
  def index
    @excursions = ExcursionsFacade.list_all_excursions
  end
end
