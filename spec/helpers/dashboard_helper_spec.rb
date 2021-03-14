require 'rails_helper'

RSpec.describe DashboardHelper, type: :helper do
  describe 'dashboard for' do
     it 'returns dashboard for admin user' do
       admin_user = double
       allow(admin_user).to receive(:admin?).and_return(true)
       expect(dashboard_for(admin_user)).to eq('admin_dashboard')
     end

     it 'returns dashboard for submitted organization user' do
       submitted_organization_user = double
       allow(submitted_organization_user).to receive(:admin?).and_return(false)
       allow(submitted_organization_user).to receive_message_chain('organization.submitted?').and_return(true)
       expect(dashboard_for(submitted_organization_user)).to eq('organization_submitted_dashboard')
     end

     it 'returns dashboard for approved organization user' do
       approved_organization_user = double()
       allow(approved_organization_user).to receive(:admin?).and_return(false)
       allow(approved_organization_user).to receive_message_chain('organization.submitted?').and_return(false)
       allow(approved_organization_user).to receive_message_chain('organization.approved?').and_return(true)
       expect(dashboard_for(approved_organization_user)).to eq('organization_approved_dashboard')
     end

     it 'returns dashboard for other users' do
       
     end
   end
end
