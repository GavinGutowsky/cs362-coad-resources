require 'rails_helper'

RSpec.describe TicketsController, type: :controller do
  context 'unauthenticated users' do
    before do
      allow(controller).to receive(:current_user).and_return(build(:user))
    end

    it 'redirects to dashboard' do
      get :show, params: { id: 'Fake' }
      expect(response).to redirect_to(dashboard_url)
      post :capture, params: { id: 'Fake' }
      expect(response).to redirect_to(dashboard_url)
      post :release, params: { id: 'Fake' }
      expect(response).to redirect_to(dashboard_url)
      patch :close, params: { id: 'Fake' }
      expect(response).to redirect_to(dashboard_url)
      delete :destroy, params: { id: 'Fake' }
      expect(response).to redirect_to(dashboard_url)
    end
  end

  context 'approved organization users' do
    before do
      organization_user = build(:user, :approved_organization)
      allow(request.env['warden']).to receive(:authenticate!).and_return(organization_user)
      allow(controller).to receive(:current_user).and_return(organization_user)
    end

    it 'redirects to dashboard' do
      delete :destroy, params: { id: 'Fake' }
      expect(response).to redirect_to(dashboard_url)
    end
  end

  context 'admin users' do
    before do
      admin_user = build(:user, :admin)
      allow(request.env['warden']).to receive(:authenticate!).and_return(admin_user)
      allow(controller).to receive(:current_user).and_return(admin_user)
    end

    it 'redirects to dashboard' do
      post :capture, params: { id: 'Fake' }
      expect(response).to redirect_to(dashboard_url)
      post :release, params: { id: 'Fake' }
      expect(response).to redirect_to(dashboard_url)
    end
  end
end
