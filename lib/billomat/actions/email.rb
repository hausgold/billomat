# frozen_string_literal: true

module Billomat
  module Actions
    # This actions sends an invoice email.
    # Recipients must be passed like this:
    #   { recipients: { to: 'bob@example.org' } }
    #
    # @example
    #   Billomat::Actions::Email.new('1235', { recipiens: { to: 'a@b.org' } })
    class Email
      # @param invoice_id [String] the invoice ID
      # @param opts [Hash] the options for this action
      # @return [Billomat::Actions::Email]
      def initialize(invoice_id, opts = {})
        @invoice_id = invoice_id
        @opts = opts
      end

      # Calls the gateway.
      #
      # @return [TrueClass]
      def call
        Billomat::Gateway.new(:post, path, wrapped_data).run

        true
      end

      # Wraps the options
      #
      # @return [Hash] the wrapped email options
      def wrapped_data
        { email: @opts }
      end

      # @return [String] the path for the email action
      def path
        "/invoices/#{@invoice_id}/email"
      end
    end
  end
end
