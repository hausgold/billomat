# frozen_string_literal: true

module Billomat
  module Models
    class InvoicePayment < Base
      def self.base_path
        '/invoice-payments'
      end

      def self.resource_name
        'invoice-payment'
      end
    end
  end
end
