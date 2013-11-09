require "rubygems"
require "json"
require "oauth"
require "optparse"

authorize_url = nil
consumer_key = nil
consumer_secret = nil
access_token = nil
access_token_secret = nil
request_method = "GET"
request_headers = {}
http_post_data = nil
retry_max_count = -1
retry_interval = 60

op = OptionParser.new

op.on("-a", "--authorize-url AUTHORIZE_URL", "authorization URL", String) {|s|
  authorize_url = s
}

op.on("-k", "--key CONSUMER_KEY", "consumer key for OAuth", String) {|s|
  consumer_key = s
}

op.on("-s", "--secret CONSUMER_SECRET", "consumer secret for OAuth", String) {|s|
  consumer_secret = s
}

op.on("-t", "--token ACCESS_TOKEN", "access tokens for OAuth", String) {|s|
  access_token = s
}

op.on("-S", "--token-secret ACCESS_TOKEN_SECRET", "access token secret for OAuth", String) {|s|
  access_token_secret = s
}

op.on("-X", "--request COMMAND", "Specify request command to use", String) {|s|
  request_method = s.upcase
}

op.on("-H", "--header LINE", "Custom header to pass to server", String) {|s|
  key, value = s.split(/: /, 2)
  request_headers[key] = value
}

op.on("-d", "--data JSON", "HTTP POST data", String) {|s|
  http_post_data = JSON.parse(s)
}

op.on("-r", "--retry RETRY_COUNT", "retry count of API access", Integer) {|i|
  retry_max_count = i
}

op.on("-i", "--retry-interval RETRY_INTERVAL", "retry interval sec", Integer) {|i|
  retry_interval = i
}

op.parse!(ARGV)

if consumer_key.nil?
  $stderr.puts "consumer key is not set"
  exit 1
end

if consumer_secret.nil?
  $stderr.puts "consumer secret is not set"
  exit 1
end

if http_post_data == "@-"
  http_post_data = $stdin.read
end

url = ARGV.shift

consumer = OAuth::Consumer.new(consumer_key, consumer_secret, :site=>authorize_url)
oauth_client = OAuth::AccessToken.new(consumer, access_token, access_token_secret)

retry_count = 0

while true
  case request_method
  when "DELETE"
    response = oauth_client.delete(url)
  when "POST"
    response = oauth_client.post(url, http_post_data, request_headers)
  when "PUT"
    response = oauth_client.put(url, http_post_data, request_headers)
  else
    response = oauth_client.get(url)
  end

  case response.code
  when "200"
    puts response.body
    break
  else
    $stderr.puts "ERROR: #{response.code}, #{response.body}"
    if retry_max_count <= retry_count
      exit 1
    else
      sleep(retry_interval)
      retry_count += 1
    end
    next
  end
end
