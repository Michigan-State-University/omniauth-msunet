module OmniAuth
  module Strategies
    class MSUnet < OmniAuth::Strategies::OAuth2
      option :client_options, {
        #,:site => 'http://oauth.dev.ais.msu.edu'
        site: "http://todo-after.dev/",
        authorize_path: "/oauth/authorize",
        authorize_url: "/oauth/authorize",
        token_url: "/oauth/access_token"
      }

      uid do
        # raw_info['uuid'].to_s
        raw_info["id"]
      end

      info do
        {
          name: raw_info["name"].to_s,
          # email: raw_info["emailaddress"].to_s
          email: raw_info["email"].to_s
        }
      end

      def raw_info
        @raw_info ||= access_token.get('/api/user').parsed
      end
    end
  end
end

OmniAuth.config.add_camelization 'msunet', 'MSUnet'
