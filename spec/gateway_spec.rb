# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Billomat::Gateway do
  let(:gateway) { described_class }
  let(:good_response) {
    instance_double(RestClient::Response, code: 200, body: "null")
  }

  let(:bad_response) {
    instance_double(RestClient::Response, code: 404, body: 'error')
  }

  describe '#run' do
    context 'when API Call is successful' do
      before do
        allow(RestClient::Request)
          .to receive(:execute).and_return(good_response)
      end

      it 'calls RestClient with right arguments' do
        gateway.new(:get, '/clients', { foo: 'bar' }).run

        expect(RestClient::Request)
          .to have_received(:execute).with(hash_including({
          method: :get,
          url: 'https://example.billomat.net/api/clients',
          timeout: 5
        }))
      end
    end

    context 'when API Call is not successful' do
      before do
        allow(RestClient::Request)
          .to receive(:execute).and_return(bad_response)
      end

      it 'raises an GatewayError' do
        expect { gateway.new(:post, '/foobar', { foo: 'bar' }).run }
          .to raise_error(Billomat::GatewayError, bad_response.body)
      end
    end
  end
end
