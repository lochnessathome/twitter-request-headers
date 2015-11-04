class AuthorizationHeader
  def initialize(consumer_key, consumer_secret, oauth_token, oauth_secret)
    @consumer_key = consumer_key
    @consumer_secret = consumer_secret
    @oauth_token = oauth_token
    @oauth_secret = oauth_secret
    @nonce = nonce
    @epochtime = epochtime
  end

  def header(signature)
    
  end
end
