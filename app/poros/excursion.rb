class Excursion
  attr_reader :title,
              :location,
              :place_id,
              :description,
              :id


  def initialize(data)
    @title = data[:attributes][:title]
    @location = data[:attributes][:location]
    @place_id = data[:attributes][:place_id]
    @description = data[:attributes][:description]
    @id = data[:id]
  end
end
