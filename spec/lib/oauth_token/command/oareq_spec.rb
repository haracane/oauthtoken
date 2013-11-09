require "spec_helper"
require "json"

describe "bin/oareq" do
  context "when send GET to https://api.twitter.com/1.1/statuses/home_timeline.json" do
    it "should success" do
      command = "bin/oareq" \
        + " --authorize-url #{AUTHORIZE_URL}" \
        + " --key #{CONSUMER_KEY}" \
        + " --secret #{CONSUMER_SECRET}" \
        + " --token #{ACCESS_TOKEN}" \
        + " --token-secret #{ACCESS_TOKEN_SECRET}" \
        + " https://api.twitter.com/1.1/statuses/home_timeline.json"

        result = `#{command}`

        result = JSON.parse(result)
        result.each do |s|
          expect(s["text"]).not_to be_nil
        end
        expect(result).to have_at_least(1).items
    end
  end

  context "when send POST to https://api.twitter.com/1.1/direct_messages/new.json" do
    it "should success" do
      command = "bin/oareq" \
        + " --authorize-url #{AUTHORIZE_URL}" \
        + " --key #{CONSUMER_KEY}" \
        + " --secret #{CONSUMER_SECRET}" \
        + " --token #{ACCESS_TOKEN}" \
        + " --token-secret #{ACCESS_TOKEN_SECRET}" \
        + " --request POST" \
        + " --data '{\"screen_name\":\"oareq\",\"text\":\"oareq test\"}'" \
        + " https://api.twitter.com/1.1/direct_messages/new.json"

        result = `#{command}`

        result = JSON.parse(result)
        expect(result["recipient_screen_name"]).to eq("oareq")
        expect(result["text"]).to eq("oareq test")
    end
  end
end
