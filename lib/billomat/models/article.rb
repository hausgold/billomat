# frozen_string_literal: true

module Billomat
  module Models
    # Representation of the article resource.
    class Article < Base
      # @return [String] the resource's base path
      def self.base_path
        '/articles'
      end

      # @return [String] the resource's name
      def self.resource_name
        'article'
      end
    end
  end
end
