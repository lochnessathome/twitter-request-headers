require 'test_helper'

class EscapeUriStringTest < Minitest::Test
  def test_it_accepts_an_argument
    refute_nil klass.new('hello')
  end

  def test_it_accepts_boolean_argument
    refute_nil klass.new(false)
  end

  def test_it_fails_with_no_argument
    assert_raises(ArgumentError) { klass.new() }
  end

  def test_it_fails_with_bad_arguments
    assert_raises(ArgumentError) { klass.new(nil) }
    assert_raises(ArgumentError) { klass.new('') }
    assert_raises(ArgumentError) { klass.new([1,2,3]) }
  end

  def test_it_encodes_string
    assert_equal 'Ladies%20%2B%20Gentlemen', klass.new('Ladies + Gentlemen').escape
    assert_equal 'An%20encoded%20string%21', klass.new('An encoded string!').escape
    assert_equal 'Dogs%2C%20Cats%20%26%20Mice', klass.new('Dogs, Cats & Mice').escape
  end

  private

  def klass
    ::EscapeUriString
  end
end
