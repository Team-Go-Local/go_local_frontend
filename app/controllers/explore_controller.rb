class ExploreController < ApplicationController

  def index 
    conn = Faraday.new("https://tranquil-refuge-53915.herokuapp.com/")
    response = conn.get("/api/v1/excursions")
    data = JSON.parse(response.body, symbolize_names: true)
    @excursions = data[:data].map do |excursion|
      Excursion.new(excursion)
    end
  end
end 