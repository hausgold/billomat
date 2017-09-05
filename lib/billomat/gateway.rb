# frozen_string_literal: true

require 'rest-client'
require 'json'

module Billomat
  class GatewayError < StandardError; end

  class Gateway
    attr_reader :method, :path, :body

    def initialize(method, path, body = {})
      @method   = method.to_sym
      @path     = path
      @body     = body
    end

    def run
      resp = RestClient::Request.execute(
        method:   method,
        url:      url,
        timeout:  timeout,
        headers:  headers,
        payload:  body.to_json
      )

      raise GatewayError, resp.body if resp.code > 299

      JSON.parse(resp.body)
    end

    def url
      "https://#{config.subdomain}.billomat.net/api#{path}"
    end

    def timeout
      5
    end

    def headers
      {
        'Accept'           => 'application/json',
        'Content-Type'     => 'application/json',
        'X-BillomatApiKey' => config.api_key
      }
    end

    def config
      Billomat.configuration
    end
  end
end
