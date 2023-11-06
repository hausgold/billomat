# frozen_string_literal: true

module Billomat
  # The +billomat+ gem configuration.
  class Configuration
    attr_accessor :api_key, :subdomain, :timeout, :app_id, :app_secret
    attr_reader :after_response

    # Sets a callback to be called for each API response
    #
    # @param [Proc] callback The callback
    def after_response=(callback)
      unless callback.respond_to?(:call)
        raise ArgumentError, "callback must respond to `call'"
      end

      @after_response = callback
    end
  end
end
