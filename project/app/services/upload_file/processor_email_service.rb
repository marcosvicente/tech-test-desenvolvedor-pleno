module UploadFile
  class ProcessorEmailService
    def initialize(filename)
      @filename = filename
    end

    def self.call(filename)
      new(filename).call
    end

    def call
      ActiveRecord::Base.transaction do
        create_upload_file
        process_file!
        @upload_email
      end
    end

    private

    # Colocar array de emails para salvar determinado item
    def client_from
      [
        "loja@fornecedorA.com",
      ]
    end

    def custumers_from
      [
        "contato@parceiroB.com",
      ]
    end
    def process_file!
      raw = file_item
      @upload_email.update!(status: :processing)

      select_parser(raw)

    rescue => e
      binding.pry
      @upload_email.update!(status: :failed)
    end


    def read_file
      File.read(@filename.path)
    end

    def file_item
       read_file.split("\n")
    end

    def select_parser(raw)
      if get_email_from_file(raw).in?(client_from)
        UploadFile::ParserEmail::ClientParserEmailService.new(raw: read_file, upload_file: @upload_email).call
      elsif get_email_from_file(raw).in?(custumers_from)
        UploadFile::ParserEmail::CompanyParserEmailService.new(raw: read_file, upload_file: @upload_email).call
      else
        binding.pry
        @upload_email.update!(status: :failed)
      end
    end

    def get_email_from_file(raw)
      raw[0].split("From: ").last
    end

    def create_upload_file
      @upload_email = UploadEmail.create(filename: @filename, status: :queueding)
    end
  end
end