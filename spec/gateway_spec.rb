# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Billomat::Gateway do
  let(:gateway) { Billomat::Gateway }
  let(:good_response) {
    instance_double(RestClient::Response, code: 200, body: "null")
  }

  let(:bad_response) {
    instance_double(RestClient::Response, code: 404)
  }

  describe '#run' do
    before do
      allow(RestClient::Request)
        .to receive(:execute).and_return(good_response)
    end

    it 'calls RestClient with right arguments' do
      gateway.new(:get, '/clients', { foo: 'bar' }).run

      expect(RestClient::Request)
        .to have_received(:execute).with(hash_including({
        method: :get,
        url: 'https://example.billomat.net/api/clients'
      }))
    end
  end
end
