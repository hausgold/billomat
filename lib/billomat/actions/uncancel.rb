# frozen_string_literal: true

module Billomat
  module Actions
    class Uncancel
      def initialize(invoice_id)
        @invoice_id = invoice_id
      end

      def call
        Billomat::Gateway.new(:put, path).run

        true
      end

      def path
        "/invoices/#{@invoice_id}/uncancel"
      end
    end
  end
end
