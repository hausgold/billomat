# frozen_string_literal: true

module Billomat
  module Models
    # Representation of the article-tag resource.
    class ArticleTag < Base
      # @return [String] the resource's base path
      def self.base_path
        '/article-tags'
      end

      # @return [String] the resource's name
      def self.resource_name
        'article-tag'
      end
    end
  end
end
