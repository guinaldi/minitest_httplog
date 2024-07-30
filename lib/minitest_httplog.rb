require 'httplog'
require 'minitest'

module MinitestHttplog
  class << self
    attr_accessor :current_test, :ignore_requests

    def init
      @ignore_requests = false
      HttpLog.configure do |config|
        config.logger = create_logger_decorator(config.logger)
      end
    end

    def create_logger_decorator(logger)
      Class.new do
        def initialize(logger)
          @logger = logger
        end

        def add(severity, message = nil, progname = nil, &block)
          process_message(message)
          @logger.add(severity, message, progname, &block)
        end

        def log(severity, message = nil, progname = nil, &block)
          process_message(message)
          @logger.log(severity, message, progname, &block)
        end

        def method_missing(method, *args, &block)
          @logger.send(method, *args, &block)
        end

        def respond_to_missing?(method, include_private = false)
          @logger.respond_to?(method, include_private) || super
        end

        private

        def process_message(message)
          if message && message.match(/\[httplog\]/)
            uri = extract_uri(message)
            method = extract_method(message)

            if uri && method && !MinitestHttplog.ignore_requests
              full_message = "Unmocked HTTP request detected: #{method} #{uri} during test: #{MinitestHttplog.current_test}"

              raise Minitest::Assertion, full_message
            end
          end
        end

        def extract_uri(message)
          match = message.match(/(http[s]?:\/\/[^\s]+)/)
          match ? match[1] : nil
        end

        def extract_method(message)
          match = message.match(/Sending: ([A-Z]+)/)
          match ? match[1] : nil
        end
      end.new(logger)
    end
  end
end

MinitestHttplog.init

module Minitest
  class Test
    alias_method :run_without_httplog, :run

    def run(*args, &block)
      MinitestHttplog.current_test = self.name
      result = run_without_httplog(*args, &block)
      MinitestHttplog.current_test = nil
      result
    end
  end
end