# frozen_string_literal: true

module Billomat
  module Actions
    # This actions uncancels an canceld invoice.
    #
    # @example
    #   Billomat::Actions::Uncancel.new('1235')
    class Uncancel
      # @param invoice_id [String] the invoice ID
      # @return [Billomat::Actions::Uncancel]
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

      # @return [String] the path for the uncancel action
      def path
        "/invoices/#{@invoice_id}/uncancel"
      end
    end
  end
end
