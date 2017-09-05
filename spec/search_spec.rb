# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Billomat::Search do
  let(:search) do
    described_class.new(Billomat::Models::Client, foo: :bar)
  end

  let(:gateway) { Billomat::Gateway }
  let(:gateway_double) { instance_double(gateway) }

  let(:multiple) do
    { 'clients' => { 'client' => [{ id: 1 }, { id: 2 }, { id: 3 }] } }
  end

  let(:single) { { 'clients' => { 'client' => { id: 1 }, '@total' => 1 } } }

  describe '#run' do
    before do
      allow(gateway).to receive(:new).and_return(gateway_double)
    end

    context 'when nothing found' do
      before do
        allow(gateway_double).to receive(:run).and_return(nil)
      end

      it 'returns an empty array' do
        expect(search.run).to eq([])
      end
    end

    context 'when one record is found' do
      before do
        allow(gateway_double).to receive(:run).and_return(single)
      end

      it 'returns an array with one object' do
        expect(search.run).to be_a(Array)
      end
    end

    context 'when multiple records are found' do
      before do
        allow(gateway_double).to receive(:run).and_return(multiple)
      end

      it 'returns an array with objects' do
        expect(search.run).to be_a(Array)
      end
    end
  end
end
