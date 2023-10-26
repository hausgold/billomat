# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Billomat::Models::Base do
  let(:base) { described_class.new(id: 123, foo: 'bar') }

  before do
    allow(described_class).to \
      receive_messages(base_path: '/bases', resource_name: 'base')
  end

  it 'raises NoMethodError when attribute not available' do
    expect { base.undefined }.to raise_error(NoMethodError)
  end

  describe '#initialize' do
    it 'creates a new base model' do
      expect(base).to be_a(described_class)
    end

    it 'allows to access the data easily (#id)' do
      expect(base.id).to be_eql(123)
    end

    it 'allows to access the data easily (#foo)' do
      expect(base.foo).to be_eql('bar')
    end
  end

  describe '.find' do
    before do
      allow(Billomat::Gateway).to receive(:new).and_return(base)
      allow(base).to receive(:run).and_return('base' => { id: '123' })
    end

    it 'calls the Gateway with objects id' do
      expect(Billomat::Gateway).to receive(:new).with(:get, '/bases/123')
      described_class.find(123)
    end
  end

  describe '.where' do
    before do
      allow(Billomat::Search).to receive(:new).and_return(base)
      allow(base).to receive(:run)
    end

    it 'calls the Search with the right params' do
      expect(Billomat::Search).to \
        receive(:new).with(described_class, { foo: 'bar' })
      described_class.where(foo: 'bar')
    end
  end

  describe '#save' do
    before do
      allow(Billomat::Gateway).to receive(:new).and_return(base)
      allow(base).to receive(:run).and_return(id: 123, foo: 'bar')
    end

    context 'when object has an id' do
      it 'calls the gateway with PUT' do
        expect(Billomat::Gateway).to \
          receive(:new).with(:put, '/bases/123', Hash)
        base.save
      end
    end

    context 'when object has no id' do
      before do
        allow(base).to receive(:id).and_return(nil)
      end

      it 'calls the gateway with POST' do
        expect(Billomat::Gateway).to \
          receive(:new).with(:post, '/bases', Hash)
        base.save
      end
    end
  end

  describe '#delete' do
    before do
      allow(Billomat::Gateway).to receive(:new).and_return(base)
      allow(base).to receive(:run)
    end

    it 'calls the gateway with DELETE' do
      expect(Billomat::Gateway).to receive(:new).with(:delete, '/bases/123')
      base.delete
    end
  end
end
