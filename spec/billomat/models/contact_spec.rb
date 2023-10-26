# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Billomat::Models::Contact do
  it 'has a base path' do
    expect(described_class.base_path).to be_a(String)
  end

  it 'has a resource name' do
    expect(described_class.resource_name).to be_a(String)
  end
end
