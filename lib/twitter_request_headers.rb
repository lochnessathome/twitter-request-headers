class TwitterRequestHeaders
  require 'escape_uri_string'

  OAUTH_VERSION = '1.0'
  OAUTH_CIPHER = 'HMAC-SHA1'
  TWITTER_API = 'https://api.twitter.com/1.1'

  class << self
    attr_reader :consumer_key, :consumer_secret, :oauth_version, :oauth_cipher, :twitter_api

    def configure(consumer_key, consumer_secret, oauth_version = nil, oauth_cipher = nil, twitter_api = nil)
      @@consumer_key = consumer_key
      @@consumer_secret = consumer_secret
      @@oauth_version = oauth_version || OAUTH_VERSION
      @@oauth_cipher = oauth_cipher || OAUTH_CIPHER
      @@twitter_api = twitter_api || TWITTER_API

      @@configured = true
    end
  end


  def initialize(oauth_token, oauth_secret, request_verb, request_path, request_params = nil)
    unless @@configured
      fail StandardError, "Call #{self.class}.configure first!"
    end

    @oauth_token = oauth_token
    @oauth_secret = oauth_secret

    @request_verb = request_verb
    @request_path = request_path
    @request_params = request_params || {}

    @nonce = nonce
    @epochtime = epochtime
  end

  private

  def nonce
    SecureRandom.hex(16)
  end

  def epochtime
    Time.now.to_i.to_s
  end

  def escape_uri_string(string)
    EscapeUriString.new(string).escape
  end
end
