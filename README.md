# OmniAuth MSUnet

This is the official OmniAuth strategy for authenticating to [Michigan State University](http://www.msu.edu) MSUnet. To
use it, you'll need to sign up for an OAuth2 Application ID and Secret
on the [MSUnet Applications Page](https://oauth.msu.edu/settings/applications).

## Installation

To install this gem you need to use:
gem install omniauth-msunet --pre

## Basic Usage

    use OmniAuth::Builder do
      provider :msunet, ENV['MSUNET_KEY'], ENV['MSUNET_SECRET']
    end

## License

TODO: Add license from MSU General Counsel & MSU Intellectual Property Office.

