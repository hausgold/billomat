# frozen_string_literal: true

module Billomat
  module Models
    # Representation of the client-tag resource.
    class ClientTag < Base
      # @return [String] the resource's base path
      def self.base_path
        '/client-tags'
      end

      # @return [String] the resource's name
      def self.resource_name
        'client-tag'
      end
    end
  end
end
