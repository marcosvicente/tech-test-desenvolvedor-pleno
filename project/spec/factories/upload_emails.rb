FactoryBot.define do
  factory :upload_email do
    filename { nil }
    customer { nil }
    status { "MyString" }
  end
end
