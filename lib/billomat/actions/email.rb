# frozen_string_literal: true

# This actions sends an invoice email
# Recipients must be passed like this:
# { recipients: { to: 'bob@example.org' } }

module Billomat
  module Actions
    class Email
      def initialize(invoice_id, opts = {})
        @invoice_id = invoice_id
        @opts = opts
      end

      def call
        Billomat::Gateway.new(:post, path, wrapped_data).run

        true
      end

      def wrapped_data
        { email: @opts }
      end

      def path
        "/invoices/#{@invoice_id}/email"
      end
    end
  end
end
