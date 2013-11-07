require 'spec_helper'

describe OAuthToken do
  it 'should have a version number' do
    OAuthToken::VERSION.should_not be_nil
  end
end
