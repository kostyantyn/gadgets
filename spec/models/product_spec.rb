require 'spec_helper'

describe Product do
  let(:product) { Product.create!(name: 'my product') }

  describe 'has_many pictures' do
    it 'should have many pictures' do
      2.times { product.pictures.create! }
      product.should have(2).pictures
    end

    it 'should destroy all pictures when product is destroyed' do
      2.times { product.pictures.create! }
      product.destroy
      Picture.count.should be(0)
    end
  end

  describe '.search' do
    it 'should filter products by name' do
      2.times { Product.create!(name: 'Product one') }
      2.times { Product.create!(name: 'Gadget one') }

      Product.search(name: 'one').should have(4).products
      Product.search(name: 'Pro').should have(2).products
    end

    it 'should return all products if name param is missed' do
      2.times { Product.create! }
      Product.search.should have(2).products
    end
  end
end
