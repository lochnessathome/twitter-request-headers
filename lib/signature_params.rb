class SignatureParams
  require 'active_support'
  require 'active_support/core_ext'

  require 'twitter_request_headers'
  require 'escape_uri_string'

  def initialize(oauth_token, nonce, epochtime, request_params)
    @oauth_token = oauth_token
    @nonce = nonce
    @epochtime = epochtime
    @request_params = request_params.stringify_keys
  end

  def params
    params_hash = {
      'oauth_consumer_key' => TwitterRequestHeaders.consumer_key,
      'oauth_signature_method' =>	TwitterRequestHeaders.oauth_cipher,
      'oauth_version' => TwitterRequestHeaders.oauth_version,
      'oauth_token' => @oauth_token,
      'oauth_nonce' => @nonce,
      'oauth_timestamp' => @epochtime
    }

    params_hash.merge!(@request_params)

    params_array = params_hash.sort.to_h.map do |key, val|
      escaped_key = EscapeUriString.new(key).escape
      escaped_val = EscapeUriString.new(val).escape

      "#{escaped_key}=#{escaped_val}"
    end

    params_array.join('&')
  end
end
