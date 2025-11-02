module UploadFile
  module ParserEmail
    class CompanyParserEmailService < BaseParserService
      def intance_customer
        name = @raw[/^(?:Cliente|Nome completo|Nome do cliente):\s*(.+)$/i, 1]
        email = @raw[/^(?:Email|E-?mail de contato):\s*([^\s]+)$/i, 1]
        phone = @raw[/^Telefone:\s*([\+\d\s\-\(\)]+)/i, 1]
        cod_product = @raw[/^(?:Produto(?:\s+de\s+interesse)?|C[oó]digo do produto):\s*([A-Z0-9\-]+)/i, 1]
        subject_email = @raw[/^Subject:\s*(.+)$/i, 1]


        @custumer = Customer.create!(
          name: name,
          email: email,
          phone: phone,
          cod_product: cod_product,
          subject_email: subject_email
        )
        @upload_file.update!(customer: @custumer, status: :done) if @custumer.persisted?
      end
    end
  end
end