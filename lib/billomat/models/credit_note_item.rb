# frozen_string_literal: true

module Billomat
  module Models
    # Representation of the credit note item resource
    class CreditNoteItem < Base
      # @return [String] the resource's base path
      def self.base_path
        '/credit-note-items'
      end

      # @return [String] the resource's name
      def self.resource_name
        'credit-note-item'
      end
    end
  end
end
