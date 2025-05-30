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

    context 'with a json body' do
      let(:bad_body) { '{"errors":{"error":"invalid secret"}}' }

      it 'returns the details' do
        expect(error.to_s).to match(/invalid secret/)
      end
    end

    context 'with an html body' do
      # include body bloating to be able to test prefix snipping
      let(:bad_body) do
        <<~HTML
          <html>
            <head>
              <title>502 Bad Gateway</title>
            </head>
            <body>
              <h1>Bad Gateway</h1>
              <div>Gateway not responding</div>
              #{'x' * 1024}
            </body>
          </html>
        HTML
      end

      it 'returns the first 128 bytes of the body' do
        expected_string = "RestClient::Exception ('#{bad_body[0, 127]}')"

        expect(error.to_s).to eql(expected_string)
      end
    end

    context 'without a body' do
      it 'only returns the original error message' do
        expect(error.to_s).to eql('RestClient::Exception')
      end
    end
  end

  describe '#run' do
    let(:callback) { instance_double(Proc) }

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

      it 'invokes after_response callback with response' do
        expect(callback).to receive(:call).with(good_response)

        Billomat.configuration.after_response = callback
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
