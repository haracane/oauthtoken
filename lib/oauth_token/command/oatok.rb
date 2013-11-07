require "oauth"
require "oauth/consumer"
require "optparse"

op = OptionParser.new

consumer_key = nil
consumer_secret = nil
oauth_url = nil

op.on("-k", "--key CONSUMER_KEY", "consumer key for OAuth", String) {|s|
  consumer_key = s
}

op.on("-s", "--secret CONSUMER_SECRET", "consumer secret for OAuth", String) {|s|
  consumer_secret = s
}

op.on("-u", "--url OAUTH_URL", "URL for OAuth", String) {|s|
  oauth_url = s
}

begin
  op.parse!(ARGV)
rescue \
  OptionParser::InvalidOption, \
  OptionParser::MissingArgument, \
  OptionParser::AmbiguousOption => e
  puts e
  exit 1
end

if oauth_url.nil?
  puts "OAuth url is not set"
  exit 1
end

if consumer_key.nil?
  puts "consumer key is not set"
  exit 1
end

if consumer_secret.nil?
  puts "consumer secret is not set"
  exit 1
end

@consumer = OAuth::Consumer.new(
  consumer_key,
  consumer_secret,
  :site=>oauth_url
)

@request_token = @consumer.get_request_token
authorize_url = @request_token.authorize_url

puts "Authorize URL: #{authorize_url}"

print "Enter PIN: "

@access_token = @request_token.get_access_token(:oauth_verifier => $stdin.gets.chomp)

puts "Access Token: #{@access_token.token}"
puts "Access Token Secret: #{@access_token.secret}"
