require 'rails_helper'

RSpec.describe 'Deleting a Ticket', type: :feature do

  let(:admin) do
    admin = create(:user, :admin)
    admin.confirm
    return admin
  end

  specify 'succeeds' do
    ticket = create(:ticket)
    log_in_as(admin)
    click_on ticket.name
    click_on 'Delete'
    expect(page.body).not_to have_selector(:link_or_button, ticket.name)
  end

end
