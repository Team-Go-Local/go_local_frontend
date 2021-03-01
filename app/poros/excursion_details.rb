class ExcursionDetails 
  attr_reader :name,
              :location, 
              :place_id, 
              :description
              

  def initialize(data) 
    # in tha facade pass it [:data][:attributes]
    # attributes need to be changed to what we will show on show
    # location, title 
    @title = data[:data][:attributes][:name]
    @location = data[:data][:attributes][:formatted_address]
    @place_id = data[:data][:attributes][:place_id]
    @description = data[:data][:attributes][:types]
  end
end
