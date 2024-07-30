# MinitestHttplog

Ruby gem designed to detect unmocked HTTP requests during tests using [Minitest](https://github.com/seattlerb/minitest) and [HttpLog](https://github.com/trusche/httplog). It intercepts HTTP requests made during tests and logs failures if any unmocked requests are detected, ensuring all external calls are properly mocked, thus improving the reliability and predictability of tests.

## Features

* Automatic Detection: Automatically intercepts and detects all unmocked HTTP requests during tests.
* Minitest Integration: Logs failures in Minitest when an unmocked request is detected, ensuring the error is visible in test results.
* Detailed Logging: Logs detailed messages about unmocked requests, including the HTTP method, URI, and the test name.
* Easy Configuration: Simple configuration and conditional activation only in the test environment.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'minitest_httplog'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install minitest_httplog

## Usage

To use `minitest_httplog` in your tests, you need to require it in your test helper file. This gem will help you detect any unmocked HTTP requests in your tests.

Here's a simple example of how to use it:

1. Add the following line to your test helper file:

```ruby
require 'minitest/httplog'
```

2. Now, when you run your tests, `minitest_httplog` will raise an exception log on any HTTP requests and raise an error if they are not mocked.

```console
Failure:
test [path]:
Unmocked HTTP request detected: POST http://test.url during test: test_
```
## Configuration

MinitestHttplog provides an option to ignore HTTP requests during specific test scenarios, such as when recording new VCR cassettes. This can be configured by setting the MinitestHttplog.ignore_requests attribute.

Example using VCR gem:

```ruby
VCR.configure do |config|
  config.cassette_library_dir = 'test/vcr_cassettes'
  config.hook_into :webmock
  config.ignore_localhost = true
  config.allow_http_connections_when_no_cassette = false

  # Configure VCR to ignore requests during recording
  config.before_record do |i|
    MinitestHttplog.ignore_requests = true
  end

  config.after_record do |i|
    MinitestHttplog.ignore_requests = false
  end
end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/minitest_httplog. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/[USERNAME]/minitest_httplog/blob/master/CODE_OF_CONDUCT.md).


## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the MinitestHttplog project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/minitest_httplog/blob/master/CODE_OF_CONDUCT.md).
