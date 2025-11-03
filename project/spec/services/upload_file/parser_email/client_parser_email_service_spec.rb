require 'rails_helper'

RSpec.describe UploadFile::ParserEmail::ClientParserEmailService do
  let(:file) { fixture_file_upload('emails/email1.eml', 'text/plain') }
  let(:raw_file) { File.read(file) }
  let(:upload_file) { create(:upload_email) }

  describe '#call' do
    it 'should be persist file email' do
      described_class.new(raw: raw_file, upload_file: upload_file).call
      upload_file.reload
      upload = upload_file.customer

      expect(upload.name).to include('João da Silva')
      expect(upload.email).to eq('joao.silva@example.com')
      expect(upload.phone).to include('11')
      expect(upload.cod_product).to eq('ABC123')
      expect(upload.subject_email).to include('ABC123')
    end
  end
end