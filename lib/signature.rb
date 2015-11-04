class Signature
  require 'securerandom'
  require 'base64'

  def initialize(consumer_key, consumer_secret, oauth_token, oauth_secret)
    @consumer_key = consumer_key
    @consumer_secret = consumer_secret
    @oauth_token = oauth_token
    @oauth_secret = oauth_secret
    @nonce = nonce
    @epochtime = epochtime
  end

  def digest(request_verb, request_path, request_params = {})
    request_digest = OpenSSL::HMAC.hexdigest(
      'sha1',
      signing_key,
      signing_base(request_verb, request_path, request_params)
    )

    Base64.encode64(Array(request_digest).pack('H*')).chomp
  end

  private



  def signing_key
    SigningKey.new(@consumer_secret, @oauth_secret).key
  end

  def signing_base(request_verb, request_path, request_params)
    SigningBase.new(
      request_verb,
      request_path,
      request_params,
      signature_params(request_params),
      @nonce,
      @epochtime,
    ).base_string
  end

  def signature_params(request_params = {})
    SignatureParams.new(
      @consumer_key,
      @oauth_token,
      @nonce,
      @epochtime,
      request_params
    ).params
  end
end

class SigningKey
  def initialize(consumer_secret, oauth_secret)
    @consumer_secret = consumer_secret
    @oauth_secret = oauth_secret
  end

  def key
    consumer_secret = escape_uri_string(@consumer_secret)
    oauth_secret = escape_uri_string(@oauth_secret)

    "#{consumer_secret}&#{oauth_secret}"
  end
end

class SigningBase
  BASE_URI = 'https://api.twitter.com/1.1'

  def initialize(request_verb, request_path, request_params, signature_params, nonce, epochtime)
    @request_verb = request_verb.upcase
    @request_path = request_path
    @request_params = request_params
    @signature_params = signature_params
    @nonce = nonce
    @epochtime = epochtime
  end

  def base_string
    escaped_path = escape_uri_string("#{self.class.base_uri}#{@request_path}")

    "#{@request_verb}&#{escaped_path}&#{@signature_params}"
  end
end

def SignatureParams
  OAUTH_VERSION = '1.0'
  OAUTH_CIPHER = 'HMAC-SHA1'

  def initialize(consumer_key, oauth_token, nonce, epochtime, request_params)
    @consumer_key = consumer_key
    @oauth_token = oauth_token
    @request_params = request_params.stringify_keys
  end

  def params
    params_hash = {
      'oauth_consumer_key' => @consumer_key,
      'oauth_token' => @oauth_token,
      'oauth_signature_method' =>	OAUTH_CIPHER,
      'oauth_version' => OAUTH_VERSION,
      'oauth_nonce' => @nonce,
      'oauth_timestamp' => @epochtime
    }

    params_hash.merge!(@request_params)

    params_array = params_hash.sort.to_h.map do |key, val|
      "#{escape_uri_string(key)}=#{escape_uri_string(val)}"
    end

    params_array.join('&')
  end
end
