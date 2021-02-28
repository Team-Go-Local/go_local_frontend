class ExcursionDetails 
  attr_reader :name,
              :address, 
              :place_id, 
              :types
              

  def initialize(data) 
    @name = data[:data][:attributes][:name]
    @address = data[:data][:attributes][:formatted_address]
    @place_id = data[:data][:attributes][:place_id]
    @types = data[:data][:attributes][:types]
    # @id = data[:id]

  end
end
