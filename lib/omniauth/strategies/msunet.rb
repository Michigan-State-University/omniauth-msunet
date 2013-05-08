require 'omniauth-oauth2'

module OmniAuth
  module Strategies
    class Msunet < OmniAuth::Strategies::OAuth2
      option :client_options, {
        :site => 'http://oauth-server.dev',
        :authorize_url => 'http://oauth-server.dev/oauth/authorize'
        #,:token_url => 'https://oauth.msu.edu/login/oauth/access_token'
      }

      def request_phase
        super
      end
      
      def authorize_params
        super.tap do |params|
          %w[scope client_options].each do |v|
            if request.params[v]
              params[v.to_sym] = request.params[v]
            end
          end
        end
      end

      uid { raw_info['id'].to_s }

      info do
        {
          'uid' => raw_info['login'],
          'email' => email,
          'name' => raw_info['name'],
        }
      end

      extra do
        {:raw_info => raw_info}
      end

      def raw_info
        access_token.options[:mode] = :query
        @raw_info ||= access_token.get('user').parsed
      end

      def email
         (raw_info['email'].nil? || raw_info['email'].empty?) ? primary_email : raw_info['email']
      end

      def primary_email
        primary = emails.find{|i| i['primary'] }
        primary && primary['email'] || emails.first && emails.first['email']
      end

      def email_access_allowed?
        options['scope'] =~ /user/
      end

    end
  end
end

OmniAuth.config.add_camelization 'msunet', 'Msunet'
