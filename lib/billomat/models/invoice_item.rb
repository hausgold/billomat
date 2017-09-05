# frozen_string_literal: true

module Billomat
  module Models
    class InvoiceItem < Base
      def self.base_path
        '/invoice-items'
      end

      def self.resource_name
        'invoice-item'
      end
    end
  end
end
