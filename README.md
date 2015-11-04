# TwitterRequestHeaders

This gem is intended to easily format Twitter API's `Authorization` HTTP header.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'twitter-request-headers'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install twitter-request-headers

## Usage

```ruby
TwitterRequestHeaders.configure(
  'KWZqnnFc8PPMjHOmXUpYNAMlI', # App ID
  '7HqOlwq7petgYbZwYIznWvaW6gxykFEoiWTliNMCNKosut5VXS' # App Secret
)

TwitterRequestHeaders.new(
  '150425432-3dAJqsCUXstN1kKgMwpFQGy9JtW6KgBeD30C1b4R', # OAuth Token
  'YHwc8jkR2pKAISscibQdymNKaXR8dzDsAabQknaJdYs9l', # OAuth Secret
  'GET',
  '/users/show.json',
  {'user_id' => '110425482'}
).header
```


## Minitest

```sh
bundle install
rake test
```

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
