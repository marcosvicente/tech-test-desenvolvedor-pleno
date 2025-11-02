module UploadFile
  module ParserEmail
    class BaseParserService
      def initialize(raw: , upload_file:)
        @raw = raw
        @upload_file = upload_file
      end


      def call
        intance_customer
      end

      def intance_customer
        raise NotImplementedError
      end
    end
  end
end