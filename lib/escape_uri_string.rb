=begin
  Twitter requires specific request encoding. More details at this link:
  https://dev.twitter.com/oauth/overview/percent-encoding-parameters
=end

require 'uri'

class EscapeUriString
  RESERVED_CHARACTERS = /[^a-zA-Z0-9\-\.\_\~]/

  def initialize(string)
    @string = string
    validate
  end

  def escape
    escaped = escape_uri(@string) || escape_uri(@string.force_encoding(Encoding::UTF_8))

    unless escaped
      fail ArgumentError, "Unable to escape string: #{@string}"
    end

    escaped
  end

  private

  def validate
    # true/false can be converted to it's string form clearly
    if @string.kind_of?(TrueClass) || @string.kind_of?(FalseClass)
      return true
    end

    # we shouldn't deal with arrays, hashes and e.g.
    unless @string.kind_of?(String)
      fail ArgumentError, 'Attempt to escape non-string'
    end

    if @string.nil? || @string.empty?
      fail ArgumentError, 'Attempt to escape empty string'
    end
  end

  def escape_uri(string)
    begin
      URI::escape(string.to_s, RESERVED_CHARACTERS)
    rescue ArgumentError
    rescue
    end
  end
end
