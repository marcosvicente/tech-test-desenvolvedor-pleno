100.times do |i|
  customer = FactoryBot.create(:customer)
  FactoryBot.create(:upload_email, customer_id: customer.id)
end