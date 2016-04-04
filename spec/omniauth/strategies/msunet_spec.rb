require 'spec_helper'
require 'omniauth-msunet'

describe OmniAuth::Strategies::MSUnet do
  let(:request) { double('Request', params: {}, cookies: {}, env: {}) }
  let(:app) { lambda { [200, {}, ["Hello."]] } }

  subject do
    OmniAuth::Strategies::MSUnet.new(app, 'appid', 'secret', @options || {}).tap do |strategy|
      allow(strategy).to receive(:request) { request }
    end
  end

  before do
    OmniAuth.config.test_mode = true
  end

  after do
    OmniAuth.config.test_mode = false
  end

  describe '#client_options' do
    it 'has correct site' do
      expect(subject.client.site).to eq('https://oauth.ais.msu.edu')
    end

    it 'has correct authorize_url' do
      expect(subject.client.options[:authorize_url]).to eq('/oauth/authorize')
    end

    it 'has correct token_url' do
      expect(subject.client.options[:token_url]).to eq('/oauth/token')
    end

    context 'overrides' do
      it 'should allow overriding the site' do
        @options = { client_options: { site: 'https://domain.com' }}
        expect(subject.client.site).to eq('https://domain.com')
      end

      it 'should allow overriding the authorize_url' do
        @options = { client_options: { authorize_url: 'https://domain.com' }}
        expect(subject.client.authorize_url).to eq('https://domain.com')
      end

      it 'should allow overriding the token_url' do
        @options = { client_options: { token_url: 'https://domain.com' }}
        expect(subject.client.token_url).to eq('https://domain.com')
      end
    end
  end

  describe '#extra' do
    let(:client) do
      OAuth2::Client.new('abc', 'def') do |builder|
        builder.request :url_encoded
        builder.adapter :test do |stub|
          stub.get('/oauth/me?access_token=') {|env| [200, {'content-type' => 'application/json'}, '{"email": "user@domain.com"}']}
        end
      end
    end
    let(:access_token) { OAuth2::AccessToken.from_hash(client, {}) }
    before { allow(subject).to receive(:access_token).and_return(access_token) }

    describe '#raw_info' do
      it 'should include raw_info' do
        expect(subject.raw_info).to eq('email' => 'user@domain.com')
      end
    end
  end

  describe '#callback_path' do
    it 'has the correct default callback path' do
      expect(subject.callback_path).to eq('/auth/msunet/callback')
    end

    it 'should set the callback_path parameter if present' do
      @options = {callback_path: '/login'}
      expect(subject.callback_path).to eq('/login')
    end
  end
end
