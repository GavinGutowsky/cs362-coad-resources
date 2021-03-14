require 'rails_helper'

RSpec.describe 'Approving an organization', type: :feature do

  let(:admin) do
    admin = create(:user, :admin)
    admin.confirm
    return admin
  end

  specify 'succeeds' do
    organization = create(:organization)
    log_in_as(admin)
    click_on 'Organizations'
    click_on 'Pending'
    click_on organization.name
    click_on 'Approve'
    expect(page.body).to have_text('approved')
  end

end
