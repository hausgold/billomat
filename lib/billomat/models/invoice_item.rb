# frozen_string_literal: true

module Billomat
  module Models
    ##
    # Representation of the invoice item resource.
    class InvoiceItem < Base
      # @return [String] the resource's base path
      def self.base_path
        '/invoice-items'
      end

      # @return [String] the resource's name
      def self.resource_name
        'invoice-item'
      end
    end
  end
end
