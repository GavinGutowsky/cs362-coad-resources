require 'rails_helper'

RSpec.describe 'Creating a Region', type: :feature do

  let(:admin) do
    admin = create(:user, :admin)
    admin.confirm
    return admin
  end

  specify 'succeeds' do
    region_name = 'Fake Region'
    log_in_as(admin)
    click_on 'Regions'
    click_on 'Add Region'
    fill_in 'Name', with: region_name
    click_on 'Add Region'
    expect(page.body).to have_selector(:link_or_button, region_name)
  end

end
