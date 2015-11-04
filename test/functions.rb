module Functions
  def self.setup
    consumer_key = 'xvz1evFS4wEEPTGEFPHBog'
    consumer_secret = 'kAcSOqF21Fu85e7zjz7ZN2U4ZRhfV3WpwPAoE3Z7kBw'

    oauth_version = '1.0'
    oauth_cipher = 'HMAC-SHA1'
    twitter_api = 'https://api.twitter.com/1'

    ::TwitterRequestHeaders.configure(
      consumer_key,
      consumer_secret,
      oauth_version,
      oauth_cipher,
      twitter_api
    )
  end
end
