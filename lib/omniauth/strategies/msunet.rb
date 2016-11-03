require 'omniauth-oauth2'
require 'multi_json'

module OmniAuth
  module Strategies
    class MSUnet < OmniAuth::Strategies::OAuth2
      option :client_options, {
        site: "https://oauth.itservices.msu.edu",
        authorize_url: "/oauth/authorize",
        token_url: "/oauth/token"
      }

      uid do
        raw_info['uid'].to_s
      end

      info do
        {
          name: raw_info['info']['name'].to_s || raw_info['name'].to_s,
          first_name: raw_info['info']['first_name'].to_s || raw_info['first_name'].to_s,
          last_name: raw_info['info']['last_name'].to_s || raw_info['last_name'].to_s,
          email: raw_info['info']['email'].to_s || raw_info['email'].to_s,
          msunetid: raw_info['info']['msunetid'].to_s || raw_info['msunetid'].to_s
        }
      end

      extra do
        { raw_info: raw_info }
      end

      def raw_info
        @raw_info ||= MultiJson.load(access_token.get("/oauth/me?access_token=#{access_token.token}").body)
      end

    end
  end
end

OmniAuth.config.add_camelization 'msunet', 'MSUnet'
