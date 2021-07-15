# frozen_string_literal: true

require 'billomat/actions/complete'
require 'billomat/actions/email'
require 'billomat/actions/pdf'
require 'billomat/actions/cancel'
require 'billomat/actions/uncancel'

module Billomat
  # Actions are API calls that do not directly represent a resource.
  # They are mostly non-RESTful actions that are called on a resources.
  module Actions; end
end
