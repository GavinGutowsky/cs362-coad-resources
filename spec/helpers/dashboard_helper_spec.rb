require 'rails_helper'

RSpec.describe DashboardHelper, type: :helper do
  describe 'dashboard for' do
     it 'returns dashboard for admin user' do
       admin_user = double
       allow(admin_user).to receive(:admin?).and_return(true)
       expect(dashboard_for(admin_user)).to eq('admin_dashboard')
     end

     it 'returns dashboard for submitted organization user' do
       
     end

     it 'returns dashboard for approved organization user' do
       
     end

     it 'returns dashboard for other users' do
       
     end
   end
end
