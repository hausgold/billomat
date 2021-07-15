# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Billomat::Gateway do
  let(:gateway) { described_class }
  let(:good_response) do
    instance_double(RestClient::Response, code: 200, body: 'null')
  end

  let(:bad_response) do
    instance_double(RestClient::Response, code: 404, body: 'error')
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
        allow(RestClient::Request).to \
          receive(:execute).and_return(bad_response)
      end

      it 'raises an GatewayError' do
        expect { gateway.new(:post, '/foobar', foo: 'bar').run }.to \
          raise_error(Billomat::GatewayError, bad_response.body)
      end
    end
  end
end
