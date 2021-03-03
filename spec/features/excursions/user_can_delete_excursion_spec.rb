require 'rails_helper'

describe 'Excursion Delete' do
  it 'can edit an excursion and be redirected to dashboard' do
    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    excursion = Excursion.new({ id: 5,
                                attributes: {
                                title: 'Cabrini Bridge',
                                description: 'cool hangout spot',
                                location: 'Harding Drive, New Orleans, LA, USA'
                                }})

    allow(DashboardFacade).to receive(:user_excursions).and_return([excursion])
    allow(ExcursionsFacade).to receive(:destroy_excursion).and_return(200)

    visit dashboard_path
    allow(DashboardFacade).to receive(:user_excursions).and_return([])
    within('#my_excursions') do
      click_link('Delete')
    end
    expect(current_path).to eq(dashboard_path)
    expect(page).to_not have_content(excursion.title)
    expect(page).to have_content("You have successfully deleted an Excursion!")
  end
end
