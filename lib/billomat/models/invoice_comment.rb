# frozen_string_literal: true

module Billomat
  module Models
    ##
    # Representation of the invoice comment resource.
    class InvoiceComment < Base
      # @return [String] the resource's base path
      def self.base_path
        '/invoice-comments'
      end

      # @return [String] the resource's name
      def self.resource_name
        'invoice-comment'
      end
    end
  end
end
