require 'spec_helper'

describe User do
  let(:user) { User.create!(email: 'admin@admin.com', password: 'admin123', password_confirmation: 'admin123') }

  it 'should have many products' do
    user.products.create!(name: 'one')
    user.products.create!(name: 'two')
    user.should have(2).products
  end

  it 'should destroy all pictures when user model is destroyed' do
    product1 = user.products.create!(name: 'one')
    product2 = user.products.create!(name: 'two')
    user.destroy
    lambda { product1.reload }.should raise_error(ActiveRecord::RecordNotFound)
    lambda { product2.reload }.should raise_error(ActiveRecord::RecordNotFound)
  end
end
