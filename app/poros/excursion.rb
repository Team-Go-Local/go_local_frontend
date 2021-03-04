class Excursion
  attr_reader :title,
              :location,
              :place_id,
              :description,
              :id,
              :nearest_city

  def initialize(data)
    @title = data[:attributes][:title]
    @location = data[:attributes][:location] || data[:attributes][:formatted_address]
    @place_id = data[:attributes][:place_id]
    @description = data[:attributes][:description]
    @id = data[:id]
    @nearest_city = data[:attributes][:nearest_city]
  end
end
