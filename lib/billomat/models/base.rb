# frozen_string_literal: true

module Billomat
  module Models
    class Base
      attr_accessor :data

      def self.find(id)
        return nil if id.nil?
        resp = Billomat::Gateway.new(:get, "#{base_path}/#{id}").run
        new(resp[resource_name])
      end

      def self.where(hash = {})
        Billomat::Search.new(self, hash).run
      end

      def initialize(data = {})
        @data = data
      end

      def save
        return create if id.blank?
        update
      end

      def create
        resp = Billomat::Gateway.new(
          :post, self.class.base_path, wrapped_data
        ).run

        @data = resp[self.class.resource_name]

        true
      end

      def update
        path = "#{self.class.base_path}/#{id}"
        resp = Billomat::Gateway.new(:put, path, wrapped_data).run
        @data = resp[self.class.resource_name]

        true
      end

      def delete
        path = "#{self.class.base_path}/#{id}"
        Billomat::Gateway.new(:delete, path).run

        true
      end

      def id
        @data['id'] || nil
      end

      def wrapped_data
        { self.class.resource_name => @data }
      end

      def method_missing(method, *args, &block)
        return @data[method.to_s] if @data.keys.include?(method.to_s)
        super
      end

      def respond_to_missing?(method, include_privat = false)
        @data.keys.include?(method.to_s) || super
      end
    end
  end
end
