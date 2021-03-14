require 'rails_helper'

RSpec.describe 'Deleting a Resource Category', type: :feature do
  
  let(:admin) do
    admin = create(:user, :admin)
    admin.confirm
    return admin
  end

  specify 'succeeds' do
    ResourceCategory.create(name: 'Fake Category')
    log_in_as(admin)
    click_on 'Categories'
    click_on 'Fake Category'
    click_on 'Delete'
    expect(page.body).not_to have_selector(:link_or_button, 'Fake Category')
  end

end
