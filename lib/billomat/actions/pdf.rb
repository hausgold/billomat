# frozen_string_literal: true

module Billomat
  module Actions
    ##
    # This class allows to download the invoice as a pdf.
    # The PDF comes in a base64 encoded string in the response body.
    class Pdf
      # @param [String] invoice_id The invoice ID
      # @param [Hash] opts The options for this action
      #
      # @return [Billomat::Actions::Pdf]
      def initialize(invoice_id, opts = {})
        @invoice_id = invoice_id
        @opts = opts
      end

      ##
      # Calls the gateway
      #
      # @return [TrueClass]
      def call
        resp = Billomat::Gateway.new(:get, path).run
        resp['pdf']
      end

      ##
      # Wraps the options
      #
      # @return [Hash] The wrapped email options
      def path
        "/invoices/#{@invoice_id}/pdf"
      end
    end
  end
end
