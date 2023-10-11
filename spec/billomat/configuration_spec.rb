# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Billomat::Configuration do
  let(:configuration) { described_class.new }

  describe '.after_response=' do
    it 'sets after_response' do
      callback = proc {}
      configuration.after_response = callback
      expect(configuration.after_response).to eq(callback)
    end

    it 'raises an error when assigned a non proc' do
      expect { configuration.after_response = :foo }.to raise_error(ArgumentError)
    end
  end
end
