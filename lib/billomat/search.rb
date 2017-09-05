# frozen_string_literal: true

require 'uri'

module Billomat
  class Search
    def initialize(resource, hash)
      @resource = resource
      @hash     = hash
    end

    def path
      "#{@resource.base_path}?#{hash_to_query}"
    end

    def run
      return [] if @hash.compact.empty?
      to_array(Billomat::Gateway.new(:get, path).run)
    end

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

    def name
      @resource.resource_name
    end

    def count(resp)
      return 0 if resp.nil?
      resp["#{name}s"]['@total'].to_i
    end

    private

    def hash_to_query
      URI.encode_www_form(@hash)
    end
  end
end
