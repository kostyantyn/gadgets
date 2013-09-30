require 'spec_helper'

describe Product do
  let(:product) { Product.create!(name: 'my product') }

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
