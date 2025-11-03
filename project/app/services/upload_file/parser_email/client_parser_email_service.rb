module UploadFile
  module ParserEmail
    class ClientParserEmailService < BaseParserService
      def intance_customer
        name = @raw[/Nome(?:\s+do\s+cliente)?:\s*(.+)/i, 1]
        name ||= @raw[/^Assinatura[,\s]*\n(.+)/i, 1]
        email = @raw[/E-?mail:\s*([^\s]+)/i, 1]
        phone = @raw[/Telefone:\s*([\(\)\d\s\-\+]+)/i, 1]
        cod_product = @raw[/produto(?:\s+de\s+c[oó]digo)?\s*([A-Z0-9\-]+)/i, 1] || raw[/Produto\s*([A-Z0-9\-]+)/i, 1]
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