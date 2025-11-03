FactoryBot.define do
  factory :upload_email do
    filename { File.open("#{Rails.root}/spec/fixtures/files/emails/email1.eml") }
    customer { create(:customer) }
    status { "queueding" }
  end
end
