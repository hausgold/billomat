# frozen_string_literal: true

require 'rest-client'
require 'json'

module Billomat
  ##
  # Raised if something goes wrong during an API call
  class GatewayError < StandardError; end

  ##
  # This class can be used by the gem to communicate with the API
  class Gateway
    attr_reader :method, :path, :body

    ##
    # Creates a new Gateway
    #
    # @param [Symbol] method The HTTP verb
    # @param [String] path The path of the resource
    # @param [Hash] body The payload for the request
    #
    # @example
    #   Billomat::Gateway.new(:get, '/invoices')
    #   Billomat::Gateway.new(:post, '/invoices', { 'invoice' => { ... } })
    def initialize(method, path, body = {})
      @method   = method.to_sym
      @path     = path
      @body     = body
    end

    ##
    # Executes the API call
    # @return [Hash] The response body
    def run
      resp = RestClient::Request.execute(
        method:   method,
        url:      url,
        timeout:  timeout,
        headers:  headers,
        payload:  body.to_json
      )

      raise GatewayError, resp.body if resp.code > 299
      return nil if resp.body.empty?

      JSON.parse(resp.body)
    end

    # @return [String] The complete URL for the request
    def url
      "https://#{config.subdomain}.billomat.net/api#{path}"
    end

    # @return [Integer]
    def timeout
      config.timeout || 5
    end

    # @return [Hash] The headers for the request.
    def headers
      {
        'Accept'           => 'application/json',
        'Content-Type'     => 'application/json',
        'X-BillomatApiKey' => config.api_key
      }
    end

    # @return [Billomat::Configuration] The global gem configuration
    def config
      Billomat.configuration
    end
  end
end
