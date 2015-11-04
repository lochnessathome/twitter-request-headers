$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

require 'twitter_request_headers'
require 'escape_uri_string'
require 'signature_params'
require 'signing_base'
require 'signing_key'

require 'minitest/autorun'
