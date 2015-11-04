require 'test_helper'
require 'functions'

class SigningKeyTest < Minitest::Test
  def setup
    # Test data published by Twitter
    Functions.setup

    @oauth_secret = 'LswwdoUaIvS8ltyTt5jkRh4J50vUPVVHtR2YPi5kE'
    @encoded_string = 'kAcSOqF21Fu85e7zjz7ZN2U4ZRhfV3WpwPAoE3Z7kBw&LswwdoUaIvS8ltyTt5jkRh4J50vUPVVHtR2YPi5kE'
  end


  def test_it_accepts_arguments
    refute_nil klass.new(@oauth_secret)
  end

  def test_it_fails_with_no_argument
    assert_raises(ArgumentError) { klass.new() }
  end

  def test_it_returns_encoded_string
    assert_equal @encoded_string,
      klass.new(@oauth_secret).key
  end

  private

  def klass
    ::SigningKey
  end
end
