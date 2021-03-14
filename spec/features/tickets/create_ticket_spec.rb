require 'rails_helper'

RSpec.describe 'Creating a Ticket', type: :feature do

  specify 'succeeds' do
    Region.create(name: 'Fake Region')
    ResourceCategory.create(name: 'Fake Resource Category')
    visit dashboard_path
    click_on 'Disaster Resource Network'
    click_on 'Get Help'
    fill_in 'Full Name', with: 'Fake Ticket'
    fill_in 'Phone Number', with: '5413308612'
    select('Fake Region', from: 'Region').select_option
    select('Fake Resource Category', from: 'Resource Category').select_option
    click_on 'Send this help request'
    expect(page.body).to have_text('Ticket Submitted')
  end

  specify 'fails when no name is entered' do
    Region.create(name: 'Fake Region')
    ResourceCategory.create(name: 'Fake Resource Category')
    visit dashboard_path
    click_on 'Disaster Resource Network'
    click_on 'Get Help'
    fill_in 'Phone Number', with: '5413308612'
    select('Fake Region', from: 'Region').select_option
    select('Fake Resource Category', from: 'Resource Category').select_option
    click_on 'Send this help request'
    expect(page.body).to have_text('error')
  end

  specify 'fails when no phone number is entered' do
    Region.create(name: 'Fake Region')
    ResourceCategory.create(name: 'Fake Resource Category')
    visit dashboard_path
    click_on 'Disaster Resource Network'
    click_on 'Get Help'
    fill_in 'Full Name', with: 'Fake Ticket'
    select('Fake Region', from: 'Region').select_option
    select('Fake Resource Category', from: 'Resource Category').select_option
    click_on 'Send this help request'
    expect(page.body).to have_text('error')
  end

  specify 'fails when no region is selected' do
    ResourceCategory.create(name: 'Fake Resource Category')
    visit dashboard_path
    click_on 'Disaster Resource Network'
    click_on 'Get Help'
    fill_in 'Full Name', with: 'Fake Ticket'
    fill_in 'Phone Number', with: '5413308612'
    select('Fake Resource Category', from: 'Resource Category').select_option
    click_on 'Send this help request'
    expect(page.body).to have_text('error')
  end

  specify 'fails when no resource category is selected' do
    Region.create(name: 'Fake Region')
    visit dashboard_path
    click_on 'Disaster Resource Network'
    click_on 'Get Help'
    fill_in 'Full Name', with: 'Fake Ticket'
    fill_in 'Phone Number', with: '5413308612'
    select('Fake Region', from: 'Region').select_option
    click_on 'Send this help request'
    expect(page.body).to have_text('error')
  end

end
