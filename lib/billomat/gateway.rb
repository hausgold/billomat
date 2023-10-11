# frozen_string_literal: true

require 'rest-client'
require 'json'

module Billomat
  # Raised if something goes wrong during an API call.
  class GatewayError < StandardError
    attr_reader :original_exception

    # Create a new GatewayError from a RestClient exception.
    #
    # @param original_exception [RestClient::Exception] the original exception
    def initialize(original_exception)
      # Extract the error from the response if it is present. If no error
      # could be extracted, use the whole body
      body = original_exception.response&.body
      response_error = JSON.parse(body).dig('errors', 'error') || body if body

      # Use the default message and append our detailed error
      message = original_exception.default_message
      message += " ('#{response_error}')" if response_error

      super(message)
      @original_exception = original_exception
    end
  end

  # This class can be used by the gem to communicate with the API.
  class Gateway
    attr_reader :method, :path, :body

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

    # Executes the API call and parse the response.
    #
    # @return [Hash] the response body
    def run
      resp = response

      return nil if resp.body.empty?

      JSON.parse(resp.body)
    rescue RestClient::Exception => e
      raise GatewayError, e
    end

    # Executes the API call and return the response.
    #
    # @return [RestClient::Response] the API response
    def response
      RestClient::Request.execute(
        method: method,
        url: url,
        timeout: timeout,
        headers: headers,
        payload: body.to_json
      ).tap { |response| Billomat.configuration.after_response&.call(response) }
    end

    # @return [String] the complete URL for the request
    def url
      "https://#{config.subdomain}.billomat.net/api#{path}"
    end

    # @return [Integer]
    def timeout
      config.timeout || 5
    end

    # @return [Hash] the headers for the request
    def headers
      {
        'Accept' => 'application/json',
        'Content-Type' => 'application/json',
        'X-BillomatApiKey' => config.api_key,
        'X-AppId' => config.app_id,
        'X-AppSecret' => config.app_secret
      }.compact
    end

    # @return [Billomat::Configuration] the global gem configuration
    #
    # :reek:UtilityFunction because it's a shorthand
    def config
      Billomat.configuration
    end
  end
end
