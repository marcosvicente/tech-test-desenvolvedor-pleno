module UploadFile
  module ParserEmail
    class BaseParserService
      def initialize(raw: , upload_file:)
        @raw = raw
        @upload_file = upload_file
      end

      def call
        binding.pry

        intance_customer
        update_upload_file
      end

      def intance_customer
        super
      end

      def update_upload_file
        @upload_file.update!(customer: @custumer)
      end
    end
  end
end