require 'test_helper'
require 'functions'

class HeaderTest < Minitest::Test
  def setup
    # Test data published by Twitter
    Functions.setup

    @oauth_token = '370773112-GmHxMAgYyLbNEtIKZeRNFsMKPR9EyMZeS9weJAEb'
    @signature = 'tnnArxj06cWHq44gCs1OSKk/jLY='
    @nonce = 'kYjzVBB8Y0ZFabxSWbWovY3uYSQ2pTgmZeNu2VS4cg'
    @epochtime = '1318622958'
  end

  def test_it_accepts_arguments
    refute_nil klass.new(@oauth_token, @signature, @nonce, @epochtime)
  end

  def test_it_fails_with_no_argument
    assert_raises(ArgumentError) { klass.new() }
  end

  def test_it_returns_header_key
    assert_equal 'Authorization', klass.key
  end

  def test_it_returns_header_value
    header_value = klass.new(@oauth_token, @signature, @nonce, @epochtime).value

    assert_match /oauth_consumer_key.+xvz1evFS4wEEPTGEFPHBog/, header_value
    assert_match /oauth_nonce.+kYjzVBB8Y0ZFabxSWbWovY3uYSQ2pTgmZeNu2VS4cg/, header_value
    assert_match /oauth_signature.+tnnArxj06cWHq44gCs1OSKk%2FjLY%3D/, header_value
    assert_match /oauth_signature_method.+HMAC-SHA1/, header_value
    assert_match /oauth_timestamp.+1318622958/, header_value
    assert_match /oauth_token.+370773112-GmHxMAgYyLbNEtIKZeRNFsMKPR9EyMZeS9weJAEb/, header_value
    assert_match /oauth_version.+1\.0/, header_value
  end

  private

  def klass
    ::Header
  end
end
