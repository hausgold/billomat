# frozen_string_literal: true

module Billomat
  module Actions
    class Pdf
      def initialize(invoice_id, opts = {})
        @invoice_id = invoice_id
        @opts = opts
      end

      def call
        resp = Billomat::Gateway.new(:get, path).run
        resp['pdf']
      end

      def path
        "/invoices/#{@invoice_id}/pdf"
      end
    end
  end
end
