require 'test_helper'
require 'functions'

class SigningBaseTest < Minitest::Test
  def setup
    # Test data published by Twitter
    Functions.setup

    @twitter_api = ::TwitterRequestHeaders.twitter_api
    @request_verb = 'POST'
    @request_path = '/statuses/update.json'
    @signature_params = 'include_entities=true&oauth_consumer_key=xvz1evFS4wEEPTGEFPHBog&oauth_nonce=kYjzVBB8Y0ZFabxSWbWovY3uYSQ2pTgmZeNu2VS4cg&oauth_signature_method=HMAC-SHA1&oauth_timestamp=1318622958&oauth_token=370773112-GmHxMAgYyLbNEtIKZeRNFsMKPR9EyMZeS9weJAEb&oauth_version=1.0&status=Hello%20Ladies%20%2B%20Gentlemen%2C%20a%20signed%20OAuth%20request%21'

    @encoded_string = 'POST&https%3A%2F%2Fapi.twitter.com%2F1%2Fstatuses%2Fupdate.json&include_entities%3Dtrue%26oauth_consumer_key%3Dxvz1evFS4wEEPTGEFPHBog%26oauth_nonce%3DkYjzVBB8Y0ZFabxSWbWovY3uYSQ2pTgmZeNu2VS4cg%26oauth_signature_method%3DHMAC-SHA1%26oauth_timestamp%3D1318622958%26oauth_token%3D370773112-GmHxMAgYyLbNEtIKZeRNFsMKPR9EyMZeS9weJAEb%26oauth_version%3D1.0%26status%3DHello%2520Ladies%2520%252B%2520Gentlemen%252C%2520a%2520signed%2520OAuth%2520request%2521'
  end


  def test_it_accepts_arguments
    refute_nil klass.new(@request_verb, @request_path, @signature_params)
  end

  def test_it_fails_with_no_argument
    assert_raises(ArgumentError) { klass.new() }
  end

  def test_it_returns_encoded_string
    assert_equal @encoded_string,
      klass.new(@request_verb, @request_path, @signature_params).base_string
  end

  private

  def klass
    ::SigningBase
  end
end
