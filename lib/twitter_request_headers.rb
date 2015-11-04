class TwitterRequestHeaders
  require 'signature'
  require 'header'

  OAUTH_VERSION = '1.0'
  OAUTH_CIPHER = 'HMAC-SHA1'
  TWITTER_API = 'https://api.twitter.com/1.1'

  class << self
    attr_reader :consumer_key, :consumer_secret, :oauth_version, :oauth_cipher, :twitter_api

    # Define Twitter application credentials and options to
    # be accessible from rest of all library.
    #
    # @param consumer_key [String] Application ID/Key
    # @param consumer_secret [String] Application Secret
    # @param oauth_version [String, nil] OAuth version used by Twitter. See dashboard.
    # @param oauth_cipher [String, nil] OAuth chipher used by Twitter. See API docs.
    # @param twitter_api [String, nil] Twitter API address. See dashboard.
    # @return [true]
    #
    def configure(consumer_key, consumer_secret, oauth_version = nil, oauth_cipher = nil, twitter_api = nil)
      @consumer_key = consumer_key
      @consumer_secret = consumer_secret

      @oauth_version = oauth_version || OAUTH_VERSION
      @oauth_cipher = oauth_cipher || OAUTH_CIPHER
      @twitter_api = twitter_api || TWITTER_API

      @@configured = true
    end
  end

  # Creates new session.
  #
  # @param oauth_token [String] Twitter OAuth Key
  # @param oauth_secret [String] Twitter OAuth Secret
  # @param request_verb [String] HTTP verb: GET, POST, e.g.
  # @param request_path [String] HTTP request path. Like /users/blah/blah
  # @param request_params [Hash, nil] HTTP request query. Like {user_id: 111222333}
  #
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

  # HTTP header of format:
  # {'Authorization' => 'OAuth ...'}
  #
  # @return [Hash]
  #
  def header
    signature = Signature.new(
      @oauth_token,
      @oauth_secret,
      @request_verb,
      @request_path,
      @request_params,
      @nonce,
      @epochtime
    ).digest

    {
      Header.key => Header.new(@oauth_token, signature, @nonce, @epochtime).value
    }
  end

  private

  def nonce
    SecureRandom.hex(16)
  end

  # Current unixtime (seconds)
  # @return [String] 1446639000
  #
  def epochtime
    Time.now.to_i.to_s
  end
end
