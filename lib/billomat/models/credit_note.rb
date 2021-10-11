# frozen_string_literal: true

module Billomat
  module Models
    # Representation of the credit note resource
    class CreditNote < Base
      # @return [String] the resource's base path
      def self.base_path
        '/credit-notes'
      end

      # @return [String] the resource's name
      def self.resource_name
        'credit-note'
      end
    end
  end
end
