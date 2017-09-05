# frozen_string_literal: true

module Billomat
  module Models
    class Client < Base
      def self.base_path
        '/clients'
      end

      def self.resource_name
        'client'
      end
    end
  end
end
