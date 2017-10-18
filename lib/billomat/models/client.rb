# frozen_string_literal: true

module Billomat
  module Models
    ##
    # Representation of the client resource
    class Client < Base
      # @return [String] The resource's base path
      def self.base_path
        '/clients'
      end

      # @return [String] The resource's name
      def self.resource_name
        'client'
      end
    end
  end
end
