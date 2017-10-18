# frozen_string_literal: true

module Billomat
  module Models
    ##
    # Representation of the invoice payment resource
    class InvoicePayment < Base
      # @return [String] The resource's base path
      def self.base_path
        '/invoice-payments'
      end

      # @return [String] The resource's name
      def self.resource_name
        'invoice-payment'
      end
    end
  end
end
