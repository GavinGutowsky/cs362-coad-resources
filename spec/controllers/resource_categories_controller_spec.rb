require 'rails_helper'

RSpec.describe ResourceCategoriesController, type: :controller do
  context 'unauthenticated users' do
    it 'redirects to sign in screen' do
      get :index
      expect(response).to redirect_to(new_user_session_url)
      get :show, params: { id: 'Fake' }
      expect(response).to redirect_to(new_user_session_url)
      get :new
      expect(response).to redirect_to(new_user_session_url)
      post :create
      expect(response).to redirect_to(new_user_session_url)
      get :edit, params: { id: 'Fake' }
      expect(response).to redirect_to(new_user_session_url)
      put :update, params: { id: 'Fake' }
      expect(response).to redirect_to(new_user_session_url)
      patch :activate, params: { id: 'Fake' }
      expect(response).to redirect_to(new_user_session_url)
      patch :deactivate, params: { id: 'Fake' }
      expect(response).to redirect_to(new_user_session_url)
      delete :destroy, params: { id: 'Fake' }
      expect(response).to redirect_to(new_user_session_url)
    end
  end

  context 'organization users' do
    before do
      organization_user = build(:user, :organization)
      allow(request.env['warden']).to receive(:authenticate!).and_return(organization_user)
      allow(controller).to receive(:current_user).and_return(organization_user)
    end

    it 'redirects to dashboard' do
      get :index
      expect(response).to redirect_to(dashboard_url)
      get :show, params: { id: 'Fake' }
      expect(response).to redirect_to(dashboard_url)
      get :new
      expect(response).to redirect_to(dashboard_url)
      post :create
      expect(response).to redirect_to(dashboard_url)
      get :edit, params: { id: 'Fake' }
      expect(response).to redirect_to(dashboard_url)
      put :update, params: { id: 'Fake' }
      expect(response).to redirect_to(dashboard_url)
      patch :activate, params: { id: 'Fake' }
      expect(response).to redirect_to(dashboard_url)
      patch :deactivate, params: { id: 'Fake' }
      expect(response).to redirect_to(dashboard_url)
      delete :destroy, params: { id: 'Fake' }
      expect(response).to redirect_to(dashboard_url)
    end
  end
end
