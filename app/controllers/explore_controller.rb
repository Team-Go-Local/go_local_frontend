class ExploreController < ApplicationController
  def index
    @excursions = ExcursionsFacade.list_all_excursions
  rescue JSON::ParserError
    @excursions = []
    flash[:notice] = "We're sorry, we were unable to locate the content you requested. Please try again later."
  end
<<<<<<< HEAD
end 
=======
end
>>>>>>> ab5746486c34f49c93f938abe79ec04af6b8dc8d
