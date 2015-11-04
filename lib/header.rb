class Header
  require 'twitter_request_headers'
  require 'escape_uri_string'

  def self.key
    'Authorization'
  end

  def initialize(oauth_token, signature, nonce, epochtime)
    @oauth_token = oauth_token
    @signature = signature

    @nonce = nonce
    @epochtime = epochtime
  end

  def value
    header_string = <<-EOF
      OAuth #{escape('oauth_consumer_key')}="#{escape(TwitterRequestHeaders.consumer_key)}",
            #{escape('oauth_nonce')}="#{escape(@nonce)}",
            #{escape('oauth_signature')}="#{escape(@signature)}",
            #{escape('oauth_signature_method')}="#{escape(TwitterRequestHeaders.oauth_cipher)}",
            #{escape('oauth_timestamp')}="#{escape(@epochtime)}",
            #{escape('oauth_token')}="#{escape(@oauth_token)}",
            #{escape('oauth_version')}="#{escape(TwitterRequestHeaders.oauth_version)}"
    EOF
  end

  private

  def escape(string)
    EscapeUriString.new(string).escape
  end
end
