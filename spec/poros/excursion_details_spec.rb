require 'rails_helper'

RSpec.describe ExcursionDetails do
  it "it exists and has attributes" do
    data = {
          "data": {
              "type": "place",
              "attributes": {
                  "place_id": "ChIJE7tYRySHa4cRSauU_fDROfk",
                  "formatted_address": "6715 W Colfax Ave, Lakewood, CO 80214, United States",
                  "name": "Casa Bonita",
                  "types": [
                      "restaurant",
                      "food",
                      "point_of_interest",
                      "establishment"
                      ]
                  }
              }
            }

    excursion = ExcursionDetails.new(data)

    expect(excursion).to be_a(ExcursionDetails)
    expect(excursion.name).to eq(data[:data][:attributes][:name])
    expect(excursion.address).to eq(data[:data][:attributes][:formatted_address])
    expect(excursion.place_id).to eq(data[:data][:attributes][:place_id])
    expect(excursion.types).to eq(data[:data][:attributes][:types])
  end 
end