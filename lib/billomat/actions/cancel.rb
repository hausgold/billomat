# frozen_string_literal: true

module Billomat
  module Actions
    # This actions cancels an invoice
    class Cancel
      # @param invoice_id [String] the invoice ID
      # @return [Billomat::Actions::Cancel]
      def initialize(invoice_id)
        @invoice_id = invoice_id
      end

      # Calls the gateway.
      #
      # @return [TrueClass]
      def call
        Billomat::Gateway.new(:put, path).run

        true
      end

      # @return [String] the cancel path with the invoice_id
      def path
        "/invoices/#{@invoice_id}/cancel"
      end
    end
  end
end
