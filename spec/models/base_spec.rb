# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Billomat::Models::Base do
  let(:base) { described_class.new(id: 123, foo: 'bar') }

  before do
    allow(described_class)
      .to receive(:base_path).and_return('/bases')
    allow(described_class)
      .to receive(:resource_name).and_return('base')
  end

  it 'raises NoMethodError when attribute not available' do
    expect { base.undefined }.to raise_error(NoMethodError)
  end

  describe '#initialize' do
    it 'creates a new base model' do
      expect(base).to be_a(Billomat::Models::Base)
    end

    it 'allows to access the data easily' do
      expect(base.id).to eq(123)
      expect(base.foo).to eq('bar')
    end
  end

  describe '.find' do
    it 'calls the Gateway with objects id' do
      allow(Billomat::Gateway)
        .to receive_message_chain(:new, :run)
        .and_return({ 'base' => { id: '123' } })

      described_class.find(123)

      expect(Billomat::Gateway).to have_received(:new).with(:get, '/bases/123')
    end
  end

  describe '.where' do
    it 'calls the Search with the right params' do
      allow(Billomat::Search)
        .to receive_message_chain(:new, :run)

      described_class.where(foo: 'bar')

      expect(Billomat::Search)
        .to have_received(:new).with(described_class, foo: 'bar')
    end
  end

  describe '#save' do
    before do
      allow(Billomat::Gateway)
        .to receive_message_chain(:new, :run)
        .and_return({ id: 123, foo: 'bar' })
    end

    context 'when object has an id' do
      it 'calls the gateway with PUT' do
        base.save

        expect(Billomat::Gateway)
          .to have_received(:new)
          .with(:put, '/bases/123', Hash)
      end
    end

    context 'when object has no id' do
      before do
        allow(base).to receive(:id).and_return(nil)
      end

      it 'calls the gateway with POST' do
        base.save

        expect(Billomat::Gateway)
          .to have_received(:new)
          .with(:post, '/bases', Hash)
      end
    end
  end

  describe '#delete' do
    before do
      allow(Billomat::Gateway)
        .to receive_message_chain(:new, :run)
    end

    it 'calls the gateway with DELETE' do
      base.delete

      expect(Billomat::Gateway)
        .to have_received(:new)
        .with(:delete, '/bases/123')
    end
  end
end
