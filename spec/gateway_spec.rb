# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Billomat::Gateway do
  let(:gateway) { described_class }
  let(:good_response) do
    instance_double(RestClient::Response, code: 200, body: 'null')
  end

  describe 'GatewayError#to_s' do
    let(:bad_response) do
      instance_double(RestClient::Response, code: 400, body: bad_body)
    end
    let(:bad_body) { nil }
    let(:rest_error) { RestClient::Exception.new(bad_response) }
    let(:error) { Billomat::GatewayError.new(rest_error) }

    context 'with a body' do
      let(:bad_body) { '{"errors":{"error":"invalid secret"}}' }

      it 'returns the details' do
        expect(error.to_s).to match(/invalid secret/)
      end
    end

    context 'without a body' do
      it 'only returns the original error message' do
        expect(error.to_s).to be_eql('RestClient::Exception')
      end
    end
  end

  describe '#run' do
    context 'when API Call is successful' do
      let(:execute_args) do
        {
          method: :get,
          url: 'https://example.billomat.net/api/clients',
          timeout: 5
        }
      end

      before do
        allow(RestClient::Request)
          .to receive(:execute).and_return(good_response)
      end

      it 'calls RestClient with right arguments' do
        expect(RestClient::Request).to \
          receive(:execute).with(hash_including(**execute_args))

        gateway.new(:get, '/clients', foo: 'bar').run
      end
    end

    context 'when API Call is not successful' do
      before do
        allow(RestClient::Request).to receive(:execute)
          .and_raise(RestClient::Exception.new)
      end

      it 'raises an GatewayError' do
        expect { gateway.new(:post, '/foobar', foo: 'bar').run }.to \
          raise_error(Billomat::GatewayError)
      end
    end
  end
end
