FactoryBot.define do
  factory :customer do
    name {  Faker::Name.name }
    email { Faker::Internet.email }
    phone { Faker::PhoneNumber.cell_phone }
    cod_product { Faker::Commerce.product_name }
    subject_email { "Subject" }
  end
end
