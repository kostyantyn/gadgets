2.times do |user_index|
  user = User.create!(email: "user#{user_index}@email.com", password: 'admin123', password_confirmation: 'admin123')

  40.times do |product_index|
    user.products.create!(name: "Product #{product_index} for user #{user_index}")
  end
end