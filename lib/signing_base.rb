class SigningBase
  require 'twitter_request_headers'
  require 'escape_uri_string'

  def initialize(request_verb, request_path, signature_params)
    @twitter_api = TwitterRequestHeaders.twitter_api
    @request_verb = request_verb.upcase
    @request_path = request_path
    @signature_params = signature_params
  end

  def base_string
    request_uri = "#{@twitter_api}#{@request_path}"
    escaped_uri = EscapeUriString.new(request_uri).escape
    escaped_params = EscapeUriString.new(@signature_params).escape

    "#{@request_verb}&#{escaped_uri}&#{escaped_params}"
  end
end
