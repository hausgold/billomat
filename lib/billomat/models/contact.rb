# frozen_string_literal: true

module Billomat
  module Models
    # Representation of the client resource.
    class Contact < Base
      # @return [String] the resource's base path
      def self.base_path
        '/contacts'
      end

      # @return [String] the resource's name
      def self.resource_name
        'contact'
      end
    end
  end
end
