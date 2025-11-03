require 'rails_helper'

RSpec.describe UploadFile::ProcessorEmailService do
  let(:file) { fixture_file_upload('emails/email1.eml', 'text/plain') }
  it 'should be persist file email' do
    upload = described_class.call(file)

    expect(upload.customer).to be_present
    expect(upload.status).to eq("done")
  end
end