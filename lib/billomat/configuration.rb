# frozen_string_literal: true

module Billomat
  # The +billomat+ gem configuration.
  class Configuration
    attr_accessor :api_key, :subdomain, :timeout, :app_id, :app_secret
  end
end
