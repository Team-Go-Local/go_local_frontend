require 'rails_helper'

RSpec.describe Excursion do
  it "it exists and has attributes" do
    data = {"id": 5,
            "type": "excursion",
            "attributes": {
                "place_id": "ChIJE7tYRySHa4cRSauU_fDROfk",
                "location": "538 Hagan Avenue, New Orleans, LA, 70119, United States",
                "title": "Parkway Bakery & Tavern",
                "description": "Longtime (since 1911) neighborhood hangout with a patio known for classic-style po' boys."
                }
              }

    excursion = Excursion.new(data)

    expect(excursion).to be_an(Excursion)
    expect(excursion.title).to eq(data[:attributes][:title])
    expect(excursion.location).to eq(data[:attributes][:location])
    expect(excursion.place_id).to eq(data[:attributes][:place_id])
    expect(excursion.description).to eq(data[:attributes][:description])
  end
end