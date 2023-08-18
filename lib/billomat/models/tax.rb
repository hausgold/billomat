# frozen_string_literal: true

module Billomat
  module Models
    # Representation of the tax resource.
    class Tax < Base
      # @return [String] the resource's base path
      def self.base_path
        '/taxes'
      end

      # @return [String] the resource's name
      def self.resource_name
        'tax'
      end
    end
  end
end
