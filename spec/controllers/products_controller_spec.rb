require 'spec_helper'

describe ProductsController do
  describe 'index' do
    it 'guests should not have access' do
      get :index
      response.should redirect_to(new_user_session_path)
    end

    it 'users should see this page' do
      sign_in User.create!(email: 'example@gmail.com', password: 'admin123', password_confirmation: 'admin123')

      get :index
      response.should be_success
    end
  end
end
