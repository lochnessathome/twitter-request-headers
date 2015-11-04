require 'test_helper'
require 'functions'

class SignatureParamsTest < Minitest::Test
  def setup
    # Test data published by Twitter
    Functions.setup

    @oauth_token = '370773112-GmHxMAgYyLbNEtIKZeRNFsMKPR9EyMZeS9weJAEb'
    @nonce ='kYjzVBB8Y0ZFabxSWbWovY3uYSQ2pTgmZeNu2VS4cg'
    @epochtime = '1318622958'
    @request_params = {
      status:	'Hello Ladies + Gentlemen, a signed OAuth request!',
      include_entities: true
    }

    @encoded_string = 'include_entities=true&oauth_consumer_key=xvz1evFS4wEEPTGEFPHBog&oauth_nonce=kYjzVBB8Y0ZFabxSWbWovY3uYSQ2pTgmZeNu2VS4cg&oauth_signature_method=HMAC-SHA1&oauth_timestamp=1318622958&oauth_token=370773112-GmHxMAgYyLbNEtIKZeRNFsMKPR9EyMZeS9weJAEb&oauth_version=1.0&status=Hello%20Ladies%20%2B%20Gentlemen%2C%20a%20signed%20OAuth%20request%21'
  end


  def test_it_accepts_arguments
    refute_nil klass.new(@oauth_token, @nonce, @epochtime, @request_params)
  end

  def test_it_fails_with_no_argument
    assert_raises(ArgumentError) { klass.new() }
  end

  def test_it_returns_encoded_string
    assert_equal @encoded_string,
      klass.new(@oauth_token, @nonce, @epochtime, @request_params).params
  end

  private

  def klass
    ::SignatureParams
  end
end
