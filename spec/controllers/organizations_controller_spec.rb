require 'rails_helper'

RSpec.describe OrganizationsController, type: :controller do
  context 'unauthenticated users' do
    it 'redirects to sign in screen' do
      get :index
      expect(response).to redirect_to(new_user_session_url)
      get :new
      expect(response).to redirect_to(new_user_session_url)
      post :create
      expect(response).to redirect_to(new_user_session_url)
      get :edit, params: { id: 'Fake' }
      expect(response).to redirect_to(new_user_session_url)
      put :update, params: { id: 'Fake' }
      expect(response).to redirect_to(new_user_session_url)
      get :show, params: { id: 'Fake' }
      expect(response).to redirect_to(new_user_session_url)
      post :approve, params: { id: 'Fake' }
      expect(response).to redirect_to(new_user_session_url)
      post :reject, params: { id: 'Fake' }
      expect(response).to redirect_to(new_user_session_url)
    end
  end

  context 'unapproved organization users' do
    before do
      unapproved_organization_user = build(:user)
      allow(request.env['warden']).to receive(:authenticate!).and_return(unapproved_organization_user)
      allow(controller).to receive(:current_user).and_return(unapproved_organization_user)
    end

    it 'redirects to dashboard' do
      get :edit, params: { id: 'Fake' }
      expect(response).to redirect_to(dashboard_url)
      put :update, params: { id: 'Fake' }
      expect(response).to redirect_to(dashboard_url)
      get :show, params: { id: 'Fake' }
      expect(response).to redirect_to(dashboard_url)
      post :approve, params: { id: 'Fake' }
      expect(response).to redirect_to(dashboard_url)
      post :reject, params: { id: 'Fake' }
      expect(response).to redirect_to(dashboard_url)
    end
  end

  context 'approved organization users' do
    before do
      approved_organization_user = build(:user, :approved_organization)
      allow(request.env['warden']).to receive(:authenticate!).and_return(approved_organization_user)
      allow(controller).to receive(:current_user).and_return(approved_organization_user)
    end

    it 'redirects to dashboard' do
      get :new
      expect(response).to redirect_to(dashboard_url)
      post :create
      expect(response).to redirect_to(dashboard_url)
      post :approve, params: { id: 'Fake' }
      expect(response).to redirect_to(dashboard_url)
      post :reject, params: { id: 'Fake' }
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
      get :new
      expect(response).to redirect_to(dashboard_url)
      post :create
      expect(response).to redirect_to(dashboard_url)
      get :edit, params: { id: 'Fake' }
      expect(response).to redirect_to(dashboard_url)
      put :update, params: { id: 'Fake' }
      expect(response).to redirect_to(dashboard_url)
    end
  end
end
