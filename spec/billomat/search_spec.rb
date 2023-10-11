# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Billomat::Search do
  let(:search) do
    described_class.new(Billomat::Models::Client, foo: :bar)
  end

  let(:gateway) { Billomat::Gateway }
  let(:gateway_double) { instance_double(gateway) }

  let(:multiple) do
    {
      'clients' => {
        'client' => [{ id: 1 }, { id: 2 }, { id: 3 }],
        '@total' => '3'
      }
    }
  end

  let(:single) do
    {
      'clients' => {
        'client' => { id: 1 },
        '@total' => '1'
      }
    }
  end

  let(:nothing) do
    {
      'clients' => {
        '@page' => '1', '@per_page' => '100', '@total' => '0'
      }
    }
  end

  describe '#run' do
    before do
      allow(gateway).to receive(:new).and_return(gateway_double)
    end

    context 'when nothing found' do
      before do
        allow(gateway_double).to receive(:run).and_return(nothing)
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

      it 'has array length of 1' do
        expect(search.run.count).to eq(1)
      end
    end

    context 'when multiple records are found' do
      before do
        allow(gateway_double).to receive(:run).and_return(multiple)
      end

      it 'returns an array with objects' do
        expect(search.run).to be_a(Array)
      end

      it 'has array length of 3' do
        expect(search.run.count).to eq(3)
      end
    end
  end
end
