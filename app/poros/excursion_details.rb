class ExcursionDetails
  attr_reader :id,
              :title,
              :description,
              :updated_at,
              :place_id,
              :address,
              :nearest_city,
              :name,
              :types,
              :phone_number,
              :website,
              :business_status,
              :opening_hours

  def initialize(data)
    @id = data[:id]
    @title = data[:attributes][:title]
    @description = data[:attributes][:description]
    @updated_at = data[:attributes][:updated_at]
    @place_id = data[:attributes][:place_id]
    @nearest_city = data[:attributes][:nearest_city]
    @address = data[:attributes][:formatted_address]
    @name = data[:attributes][:name]
    @types = data[:attributes][:types]
    @phone_number = data[:attributes][:formatted_phone_number]
    @website = data[:attributes][:website]
    @business_status = data[:attributes][:business_status]
    @opening_hours = data[:attributes][:opening_hours]
  end
end
