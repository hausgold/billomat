# frozen_string_literal: true

module Billomat
  module Models
    # Representation of the article-property-value resource.
    class ArticlePropertyValue < Base
      # @return [String] the resource's base path
      def self.base_path
        '/article-property-values'
      end

      # @return [String] the resource's name
      def self.resource_name
        'article-property-value'
      end
    end
  end
end
