# OmniAuth MSU NetID

[![Build Status](https://travis-ci.org/Michigan-State-University/omniauth-msunet.svg?branch=master)](https://travis-ci.org/Michigan-State-University/omniauth-msunet)
[![Dependency Status](https://gemnasium.com/Michigan-State-University/omniauth-oauth2.svg)](https://gemnasium.com/Michigan-State-University/omniauth-oauth2)

## Description

This is the official OmniAuth strategy gem for authenticating to [Michigan State University](https://msu.edu) MSU NetID using OAuth2. To use this gem you'll need the following:

* Contact MSU Information Technology Service Desk at 517-432-6200 to request to register your application, or complete the [OAuth 2.0 request form] (https://tech.msu.edu/network/authentication-authorization)
* Provide MSU Information Technology Identity Management with a callback URL, which is where to send successful MSU NetID authentication requests back to your application.  Note: this must be a HTTPS address.
* Receive a `client_id` token and `client_secret` token specific for your application.

## Installation

To install this gem you need to add it to your Gemfile as follows:
```gem 'omniauth-msunet'```

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
  "description":"MSU NetID OAuth2 Auth-n"
  }
}
```

## Development

1) Clone the repository
2) Write some tests
3) Make them pass
4) Request a pull

### Testing

`bundle exec rspec`

### Releasing

Use the [version](https://github.com/stouset/version) gem.  See `bundle exec
rake -T version` for commands. Bumping the version will change the `VERSION`
file, commit the changes, and create a tag.  You can then push the tag to your
remote:

```
bundle exec rake version:bump # create a minor version bump
git push # push code changes
git push origin $(bundle exec rake version) # push new tag
```

## License

Please see the LICENSE.md file.
