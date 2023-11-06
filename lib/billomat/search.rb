# frozen_string_literal: true

require 'uri'

module Billomat
  # This class provides the possibility to query the resources.
  class Search
    # Creates a new search object.
    #
    # @param [Class] resource The resource class to be queried
    # @param [Hash] hash The query
    def initialize(resource, hash)
      @resource = resource
      @hash     = hash
    end

    # @return [String] the path including the query
    def path
      "#{@resource.base_path}?#{hash_to_query}"
    end

    # Runs the query and calls the gateway.
    # Currently it will always return an empty array when no query is provided.
    #
    # @return [Array<Billomat::Model::Base>]
    def run
      return [] if @hash.compact.empty?

      resp = Billomat::Gateway.new(:get, path).run
      Billomat::Utils.to_array(resp, name, @resource)
    end

    # @return [String] the name of the resource
    def name
      @resource.resource_name
    end

    private

    # @return [String] the query as www encoded string
    def hash_to_query
      URI.encode_www_form(@hash)
    end
  end
end
