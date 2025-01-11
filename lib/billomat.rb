# frozen_string_literal: true

require 'zeitwerk'
require 'active_support'
require 'rest-client'
require 'json'
require 'ostruct'
require 'uri'

# An wrapper for the Billomat API.
module Billomat
  # Setup a Zeitwerk autoloader instance and configure it
  loader = Zeitwerk::Loader.for_gem

  # Finish the auto loader configuration
  loader.setup

  # Make sure to eager load all SDK constants
  loader.eager_load

  class << self
    attr_writer :configuration

    # @return [Billomat::Configuration] the global billomat configuration
    def configuration
      @configuration ||= Billomat::Configuration.new
    end

    # Class method to set and change the global configuration.
    #
    # @example
    #   Billomat.configure do |config|
    #     config.subdomain = 'your-business-name'
    #     config.api_key = 'a3b148a61cb642389b4f9953f6233f20'
    #   end
    def configure
      yield(configuration)
    end
  end
end
