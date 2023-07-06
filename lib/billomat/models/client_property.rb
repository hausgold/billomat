# frozen_string_literal: true

module Billomat
  module Models
    # Representation of the client-property resource.
    class ClientProperty < Base
      # @return [String] the resource's base path
      def self.base_path
        '/client-property-values'
      end

      # @return [String] the resource's name
      def self.resource_name
        'client-property-value'
      end
    end
  end
end
