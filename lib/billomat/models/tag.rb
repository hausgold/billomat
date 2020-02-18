# frozen_string_literal: true

module Billomat
  module Models
    ##
    # Representation of the tag resource
    class Tag < Base
      # @return [String] The resource's base path
      def self.base_path
        '/tags'
      end

      # @return [String] The resource's name
      def self.resource_name
        'tag'
      end
    end
  end
end
