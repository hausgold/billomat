# frozen_string_literal: true

module Billomat
  module Models
    # Representation of the tag resource.
    class Tag < Base
      # @return [String] the resource's base path
      def self.base_path
        '/tags'
      end

      # @return [String] the resource's name
      def self.resource_name
        'tag'
      end
    end
  end
end
