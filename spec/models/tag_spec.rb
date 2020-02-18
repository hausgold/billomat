# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Billomat::Models::Tag do
  it 'has a base path' do
    expect(described_class.base_path).to be
  end

  it 'has a resource name' do
    expect(described_class.resource_name).to be
  end
end