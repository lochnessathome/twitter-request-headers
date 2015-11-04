class SigningKey
  require 'twitter_request_headers'
  require 'escape_uri_string'

  def initialize(oauth_secret)
    @consumer_secret = TwitterRequestHeaders.consumer_secret
    @oauth_secret = oauth_secret
  end

  def key
    consumer_secret = EscapeUriString.new(@consumer_secret).escape
    oauth_secret = EscapeUriString.new(@oauth_secret).escape

    "#{consumer_secret}&#{oauth_secret}"
  end
end
