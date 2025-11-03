require 'rails_helper'

RSpec.describe UploadFile::ParserEmail::CompanyParserEmailService do
  let(:file) { fixture_file_upload('emails/email4.eml', 'text/plain') }
  let(:raw_file) { File.read(file) }
  let(:upload_file) { create(:upload_email) }

  describe '#call' do
    it 'should be persist file email' do
      described_class.new(raw: raw_file, upload_file: upload_file).call
      upload_file.reload
      upload = upload_file.customer

      expect(upload.name).to include('Ana')
      expect(upload.email).to eq('ana.costa@example.com')
      expect(upload.phone).to include('31')
      expect(upload.cod_product).to eq('PROD-555')
      expect(upload.subject_email).to include('PROD-555')
    end
  end
end