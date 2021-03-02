class ExploreController < ApplicationController

  def index 
    # @excursions = Faraday.get("https://tranquil-refuge-53915.herokuapp.com/api/v1/excursions")
    conn = Faraday.new("https://tranquil-refuge-53915.herokuapp.com/")
    response = conn.get("/api/v1/excursions")
    data = JSON.parse(response.body, symbolize_names: true)
    @excursions = data.map do |excursion|
      Excursion.new(excursion)
    end
  end
end