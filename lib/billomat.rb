# frozen_string_literal: true

require 'billomat/version'
require 'billomat/configuration'
require 'billomat/models'
require 'billomat/actions'
require 'billomat/search'
require 'billomat/gateway'

module Billomat
  class << self
    attr_writer :configuration
  end

  def self.configuration
    @configuration ||= Billomat::Configuration.new
  end

  def self.configure
    yield(configuration)
  end
end
