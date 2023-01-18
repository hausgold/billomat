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

      to_array(Billomat::Gateway.new(:get, path).run)
    end

    # Corrects the response to always return an array.
    #
    # @todo Due to a strange API behaviour we have to fix the reponse here.
    #   This may be fixed in a new API version.
    #
    # @param [Hash] resp The response from the gateway
    # @return [Array<Billomat::Model::Base>]
    def to_array(resp)
      case count(resp)
      when 0
        []
      when 1
        # Necessary due to strange API behaviour
        [@resource.new(resp["#{name}s"][name])]
      else
        resp["#{name}s"][name].map do |c|
          @resource.new(c)
        end
      end
    end

    # @return [String] the name of the resource
    def name
      @resource.resource_name
    end

    # @param [Hash] resp The response from the gateway
    # @return [Integer] the number of records found
    def count(resp)
      return 0 if resp.nil?

      resp["#{name}s"]['@total'].to_i
    end

    private

    # @return [String] the query as www encoded string
    def hash_to_query
      URI.encode_www_form(@hash)
    end
  end
end
