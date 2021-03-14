require 'rails_helper'

RSpec.describe 'Deleting a Region', type: :feature do

  let(:admin) do
    admin = create(:user, :admin)
    admin.confirm
    return admin
  end

  specify 'succeeds' do
    Region.create(name: 'Fake Region')
    log_in_as(admin)
    click_on 'Regions'
    click_on 'Fake Region'
    click_on 'Delete'
    expect(page.body).not_to have_selector(:link_or_button, 'Fake Region')
  end

end
