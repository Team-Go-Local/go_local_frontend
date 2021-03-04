require 'rails_helper'

RSpec.describe ExcursionDetails do
  it "it exists and has attributes" do
    data = {
          :id=>"1",
          :type=>"excursion_details",
          :attributes=>
            {:id=>1,
            :title=>"Amethyst Coffee- Broadway",
            :description=>"Local neighborhood shop for great drinks, local pastries from Rebel Bread and atmosphere. Outside seating available with fireplace. Suggest a cappuccino or Oat Milk Matcha!",
            :updated_at=>"2021-03-03T21:06:04.082Z",
            :place_id=>"ChIJSbrgrrEWcEAR3lFElZXIvO0",
            :nearest_city=>nil,
            :formatted_address=>"1111 Broadway #101, Denver, CO 80203, USA",
            :name=>"Amethyst Coffee- Broadway",
            :types=>["cafe", "bar", "food", "point_of_interest", "store", "establishment"],
            :phone_number=>nil,
            :website=>"http://amethystcoffee.co/",
            :business_status=>"OPERATIONAL",
            :opening_hours=>
              ["Monday: 7:00 AM – 1:00 PM",
              "Tuesday: 7:00 AM – 1:00 PM",
              "Wednesday: 7:00 AM – 1:00 PM",
              "Thursday: 7:00 AM – 1:00 PM",
              "Friday: 7:00 AM – 1:00 PM",
              "Saturday: 8:00 AM – 3:00 PM",
              "Sunday: 8:00 AM – 3:00 PM"]
              }
            }


    excursion_details = ExcursionDetails.new(data)

    expect(excursion_details).to be_an(ExcursionDetails)
    expect(excursion_details.title).to eq(data[:attributes][:title])
    expect(excursion_details.description).to eq(data[:attributes][:description])
    expect(excursion_details.updated_at).to eq(data[:attributes][:updated_at])
    expect(excursion_details.place_id).to eq(data[:attributes][:place_id])
    expect(excursion_details.nearest_city).to eq(data[:attributes][:nearest_city])
    expect(excursion_details.address).to eq(data[:attributes][:formatted_address])
    expect(excursion_details.name).to eq(data[:attributes][:name])
    expect(excursion_details.types).to eq(data[:attributes][:types])
    expect(excursion_details.phone_number).to eq(data[:attributes][:phone_number])
    expect(excursion_details.website).to eq(data[:attributes][:website])
    expect(excursion_details.business_status).to eq(data[:attributes][:business_status])
    expect(excursion_details.opening_hours).to eq(data[:attributes][:opening_hours])
    expect(excursion_details.id).to eq(data[:id])
  end
end
