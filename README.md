# OmniAuth MSUnet

This is the official OmniAuth strategy gem for authenticating to [Michigan State University](http://www.msu.edu) MSUnet using OAuth2. To use this gem you'll need the following:

* Contact MSU IT Services at 517-432-6200 to request to register your application.
* Provide IT Services with a callback URL, which is where to send successful MSUnet authentication requests back to your application.  Note: this must be a HTTPS address.
* Receive a `client_id` token and `client_secret` token specific for your application.

## Installation

To install this gem you need to add it to your Gemfile as follows:
```gem 'omniauth-msunet', :git => 'https://gitlab.msu.edu/tm/omniauth-msunet.git'```

## Basic Usage

If this is your applications first OmniAuth strategy then you will need to create the file config/initializers/omniauth.rb, otherwise update your existing one.

```
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :msunet, "replace_with_client_id", "replace_with_client_secret"
end
```

Next you need to setup some routes to handle the callback and if it's a success or failure.  You could use something like the following in your config/routes.rb file

```
match 'auth/:provider/callback', to: 'sessions#create'
match 'auth/failure', to: redirect('/')
match 'signout', to: 'sessions#destroy', as: 'signout'
```

Finally restart your server for all of the changes to take effect.  You can now browse to your apps URL `https://0.0.0.0/auth/msunet` to login.

Once the login is completed you should receive the following hash that you can access:

```
{
"provider":"msunet",
"uid":"xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",
"info":{
  "name":"John Sparty",
  "email":"sparty@msu.edu",
  "first_name":"John",
  "last_name":"Sparty",
  "description":"MSUNet OAuth2 Auth-n"
  }
}
```

## License

Please see the LICENSE.md file.