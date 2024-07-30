$LOAD_PATH.unshift File.expand_path("../lib", __dir__)
require "minitest_httplog"
require "minitest/autorun"
require 'webmock/minitest'
require 'byebug'

WebMock.enable_net_connect!