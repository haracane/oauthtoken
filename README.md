# Oauthtoken

'oauthtoken' is a command to get OAuth token.

## Supported Ruby versions and implementations

oauthtoken should work identically on:

* Ruby 1.9.3+
* Ruby 2.0.0+

## Installation

Add this line to your application's Gemfile:

    gem 'oauthtoken'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install oauthtoken

## Usage

Get Authorize URL:

    $ oatok --url OAUTH_URL --key CONSUMER_KEY --secret CONSUMER_SECRET
    Authorize URL: https://api.oauth.com/oauth/authorize?oauth_token=OAUTH_TOKEN
    Enter PIN: 

Access to authorize URL and enter the displayed PIN, then get access token and access token secret:

    Access Token: ACCESS_TOKEN
    Access Token Secret: ACCESS_TOKEN_SECRET

Show help:

    $ oatok --help

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
