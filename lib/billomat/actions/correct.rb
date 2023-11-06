# frozen_string_literal: true

module Billomat
  module Actions
    # This actions correct an invoice
    class Correct
      # Returns a Correct object.
      #
      # @param invoice_id [String] the ID of the invoice
      # @param opts [Hash] the options for this request
      # @return [Billomat::Actions::Complete]
      #
      # @example
      #   Billomat::Actions::Complete('12345', { template_id: '10231' })
      def initialize(invoice_id, opts = {})
        @invoice_id = invoice_id
        @opts = opts
      end

      # Calls the gateway.
      #
      # @return [TrueClass]
      def call
        Billomat::Gateway.new(:post, path, wrapped_data).run
      end

      # The given options have to be wrapped.
      #
      # @return [Hash] the payload for the correct request
      def wrapped_data
        { correct: @opts }
      end

      # @return [String] the correct path with the invoice_id
      def path
        "/invoices/#{@invoice_id}/correct"
      end
    end
  end
end
