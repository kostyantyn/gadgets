require 'spec_helper'

describe ProductsController do
  let(:current_user) do
    User.create!(email: 'example@gmail.com', password: 'admin123', password_confirmation: 'admin123')
  end

  describe 'index' do
    it 'guests should not have access' do
      get :index
      response.should redirect_to(new_user_session_path)
    end

    it 'users should see this page' do
      sign_in current_user

      get :index
      response.should be_success
    end
  end

  describe 'show' do
    it 'guests should not have access' do
      get :show, id: 1
      response.should redirect_to(new_user_session_path)
    end

    it 'users should see theirs product' do
      sign_in current_user
      product = current_user.products.create(name: 'product1')

      get :show, id: product.id
      response.should be_success
    end

    it 'users should not see others products' do
      sign_in current_user
      other_user = User.create!(email: 'other_user@gmail.com', password: 'admin123', password_confirmation: 'admin123')
      product = other_user.products.create!(name: 'product2')

      lambda do
        get :show, id: product.id
      end.should raise_error(ActiveRecord::RecordNotFound)
    end
  end

  describe 'new' do
    it 'guests should not have access' do
      get :new
      response.should redirect_to(new_user_session_path)
    end

    it 'users should see form of creating new product' do
      sign_in current_user
      get :new
      response.should be_success
    end
  end

  describe 'create' do
    it 'guests should not have access' do
      post :create
      response.should redirect_to(new_user_session_path)
    end

    it 'users should be able to create theirs product' do
      sign_in current_user
      lambda do
        post :create, products: {name: 'my new product'}
      end.should change(Product, :count).by(1)
    end
  end

  describe 'edit' do
    it 'guests should not have access' do
      get :edit, id: 1
      response.should redirect_to(new_user_session_path)
    end

    it 'users should see form of editing current product' do
      sign_in current_user
      product = current_user.products.create!(name: 'product3')

      get :edit, id: product.id
      response.should be_success
    end
  end

  describe 'update' do
    it 'guests should not have access' do
      patch :update, id: 1, product: {name: 'new name'}
      response.should redirect_to(new_user_session_path)
    end

    it 'users should be able to update theirs products' do
      sign_in current_user
      product = current_user.products.create!(name: 'old name')

      patch :update, id: product.id, product: {name: 'new name'}
      product.reload.name.should == 'new name'
    end
  end

  describe 'destroy' do
    it 'guests should not have access' do
      delete :destroy, id: 1
      response.should redirect_to(new_user_session_path)
    end

    it 'users should be able to delete theirs product' do
      sign_in current_user
      product = current_user.products.create!(name: 'my product')

      lambda do
        delete :destroy, id: product.id
      end.should change(Product, :count).by(-1)
    end
  end
end
