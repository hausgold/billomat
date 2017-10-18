# frozen_string_literal: true

require 'billomat/version'
require 'billomat/configuration'
require 'billomat/models'
require 'billomat/actions'
require 'billomat/search'
require 'billomat/gateway'

##
# An wrapper for the
# <a href="https://billomat.com">Billomat</a>
# API
module Billomat
  class << self
    attr_writer :configuration
  end

  # @return [Billomat::Configuration] The global billomat configuration
  def self.configuration
    @configuration ||= Billomat::Configuration.new
  end

  # Class method to set and change the global configuration
  #
  # @example
  #   Billomat.configure do |config|
  #     config.subdomain = 'your-business-name'
  #     config.api_key = 'a3b148a61cb642389b4f9953f6233f20'
  #   end
  def self.configure
    yield(configuration)
  end
end
