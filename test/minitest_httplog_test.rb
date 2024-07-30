require 'test_helper'
require 'net/http'

class HttpLogMinitestTest < Minitest::Test
  def setup
    stub_request(:get, "http://example.com").to_return(body: "Example Domain")
  end

  def test_http_request
    uri = URI('http://example.com')
    response = Net::HTTP.get(uri)

    assert_includes response, 'Example Domain'
  end

  def test_unmocked_request
    uri = URI('https://jsonplaceholder.typicode.com/posts/1')

    error = assert_raises(Minitest::Assertion) do
      Net::HTTP.get(uri)
    end

    assert_match(/Unmocked HTTP request detected: GET http:\/\/jsonplaceholder.typicode.com:443\/posts\/1 during test: test_unmocked_request/, error.message)
  end
end