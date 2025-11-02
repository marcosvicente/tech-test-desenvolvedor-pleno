module UploadFile
  class ProcessorEmailService
    def initialize(filename)
      @filename = filename[:filename]
    end

    def self.call(filename)
      new(filename).call
    end

    def call
      create_upload_file
      process_file!
    end

    private

    def client_headers
      [
        "Nome do cliente:",
        "Client",
      ]
    end

    def custumers_headers
      [
        "Nome completo:",
        "Nome:",
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
      klass = raw.map {|k| client_headers.include?(k) }
      if klass.include?(true)
        binding.pry
        @upload_email = UploadFile::ParserEmail::ClientParserEmailService.call(raw: raw, upload_file: @upload_email)
      else
        binding.pry
        @upload_email= UploadFile::ParserEmail::CompanyParserEmailService.call(raw: raw, upload_file: @upload_email)
      end
    end
    def create_upload_file
      @upload_email = UploadEmail.create(filename: @filename, status: :queueding)
    end
  end
end