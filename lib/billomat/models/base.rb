# frozen_string_literal: true

require 'ostruct'

module Billomat
  module Models
    # This class is the base for all other models (resources).
    # It handles the communication with the gateway to talk to the API.
    class Base
      attr_accessor :data

      # Tries to find the resource for the given id.
      #
      # @param id [String] the resource id
      # @return [Billomat::Models::Base, nil] the found resource or nil
      def self.find(id)
        return nil if id.nil?

        resp = Billomat::Gateway.new(:get, "#{base_path}/#{id}").run
        new(resp[resource_name])
      end

      # Allows to query for a record.
      #
      # @param hash [Hash] the query parameters
      # @return [Array<Billomat::Models::Base>] the found records
      def self.where(hash = {})
        Billomat::Search.new(self, hash).run
      end

      ##
      # Initializes a new model.
      #
      # @param data [Hash] the attributes of the object
      # @return [Billomat::Models::Base] the record as an object
      def initialize(data = {})
        @data = OpenStruct.new(data)
      end

      # Persists the current object in the API.
      # When record is new it calls create, otherwise it saves the object.
      #
      # @return [TrueClass]
      def save
        return create if id.nil?

        update
      end

      # @return [TrueClass]
      def create
        resp = Billomat::Gateway.new(
          :post, self.class.base_path, wrapped_data
        ).run

        @data = OpenStruct.new(resp[self.class.resource_name])

        true
      end

      # @return [TrueClass]
      def update
        path = "#{self.class.base_path}/#{id}"
        resp = Billomat::Gateway.new(:put, path, wrapped_data).run
        @data = resp[self.class.resource_name]

        true
      end

      # @return [TrueClass]
      def delete
        path = "#{self.class.base_path}/#{id}"
        Billomat::Gateway.new(:delete, path).run

        true
      end

      # @return [String, nil] the object's ID
      def id
        @data['id'] || nil
      end

      # Wraps the data so the API accepts the request.
      #
      # @example
      #   some_invoice.wrapped_data
      #   #=> { "invoice" => { "id" => "12345"  } }
      #
      # @return [Hash] the wrapped data
      def wrapped_data
        { self.class.resource_name => @data.to_h }
      end

      # Returns the object with the right JSON structure.
      #
      # @return [Hash] the objects data
      def as_json(_options = nil)
        @data.to_h
      end

      # All values in the @data hash can be accessed like a 'normal' method.
      #
      # @example
      #   invoice = Billomat::Models::Invoice.new(invoice_number: '123')
      #   invoice.invoice_number
      #   #=> '123'
      def method_missing(method, *args, &block)
        return @data[method] if @data.to_h.key?(method)

        super
      end

      # Necessary for method_missing.
      #
      # @param [Symbol] method The method name
      # @param [TrueClass, FalseClass] include_privat
      # @return [TrueClass, FalseClass]
      def respond_to_missing?(method, include_privat = false)
        @data.to_h.key?(method.to_s) || super
      end
    end
  end
end
