=begin
  Creates signature of request parameters.
  https://dev.twitter.com/oauth/overview/creating-signatures
=end

class Signature
  require 'securerandom'
  require 'base64'

  require 'signing_key'
  require 'signing_base'
  require 'signature_params'

  def initialize(oauth_token, oauth_secret, request_verb, request_path, request_params, nonce, epochtime)
    @oauth_token = oauth_token
    @oauth_secret = oauth_secret

    @request_verb = request_verb
    @request_path = request_path
    @request_params = request_params

    @nonce = nonce
    @epochtime = epochtime
  end

  def digest
    request_digest = OpenSSL::HMAC.hexdigest('sha1', signing_key, signing_base)

    Base64.encode64(Array(request_digest).pack('H*')).chomp
  end

  private

  def signing_key
    SigningKey.new(@oauth_secret).key
  end

  def signing_base
    SigningBase.new(@request_verb, @request_path, signature_params).base_string
  end

  def signature_params
    SignatureParams.new(@oauth_token, @nonce, @epochtime, @request_params).params
  end
end
