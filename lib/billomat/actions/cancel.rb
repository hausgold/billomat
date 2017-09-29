# frozen_string_literal: true

module Billomat
  module Actions
    class Cancel
      def initialize(invoice_id)
        @invoice_id = invoice_id
      end

      def call
        Billomat::Gateway.new(:put, path).run

        true
      end

      def path
        "/invoices/#{@invoice_id}/cancel"
      end
    end
  end
end
