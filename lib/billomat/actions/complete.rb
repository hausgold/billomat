# frozen_string_literal: true

module Billomat
  module Actions
    class Complete
      def initialize(invoice_id, opts = {})
        @invoice_id = invoice_id
        @opts = opts
      end

      def call
        Billomat::Gateway.new(:put, path, wrapped_data).run

        true
      end

      def wrapped_data
        { complete: @opts }
      end

      def path
        "/invoices/#{@invoice_id}/complete"
      end
    end
  end
end
