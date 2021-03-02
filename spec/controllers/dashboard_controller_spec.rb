require 'rails_helper'

RSpec.describe DashboardController, type: :controller do
  context 'unauthenticated users' do
    it 'redirects to dashboard' do
      get :index
      expect(response).to redirect_to(new_user_session_url)
    end
  end
end
