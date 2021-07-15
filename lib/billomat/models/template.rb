# frozen_string_literal: true

module Billomat
  module Models
    # Representation of the template resource.
    class Template < Base
      # @return [String] the resource's base path
      def self.base_path
        '/templates'
      end

      # @return [String] the resource's name
      def self.resource_name
        'template'
      end
    end
  end
end
