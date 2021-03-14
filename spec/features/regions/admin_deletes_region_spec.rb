require 'rails_helper'

RSpec.describe 'Deleting a Region', type: :feature do

  let(:admin) do
    admin = create(:user, :admin)
    admin.confirm
    return admin
  end

  specify 'succeeds' do
    region_name = 'Fake Region'
    Region.create(name: region_name)
    log_in_as(admin)
    click_on 'Regions'
    click_on region_name
    click_on 'Delete'
    expect(page.body).not_to have_selector(:link_or_button, region_name)
  end

end
