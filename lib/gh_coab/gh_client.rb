require "net/http"
require "benchmark"
require "json"
class GhClient
  class GhClientError < StandardError; end

  attr_accessor :client_error_class

  def initialize
    @client_error_class = GhClientError
  end

  def get_events(username)
    do_request("#{username}/events", Net::HTTP::Get)
  end

  def get_profile(username)
    do_request(username.to_s, Net::HTTP::Get)
  end

  private

  def do_request(path, type)
    uri = URI.parse("#{base_url}#{path}")
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true

    request = type.new(uri.request_uri)
    yield request if block_given?

    response = http.request(request)

    parse!(response)
  end

  def base_url
    "https://api.github.com/users/"
  end

  def parse!(response)
    parsed_response = ResponseParser.new(
      response.body, raise_on_parsing_error: client_error_class
    ).parse

    unless success?(response)
      error_message = "ERROR - code: #{response.code} - #{response.message} - #{response.body}"

      fail(
        client_error_class.new(
          error_message
        )
      )
    end

    parsed_response
  end

  class ResponseParser
    attr_reader :body, :raise_on_parsing_error

    def initialize(body, raise_on_parsing_error: nil)
      @body = body.nil? ? "{}" : body
      @raise_on_parsing_error = raise_on_parsing_error
    end

    def parse
      JSON.parse(body, symbolize_names: true)
    rescue JSON::ParserError
      Rails.logger.error("Failed to parse response that was expected to be JSON: #{body}")

      if raise_on_parsing_error
        raise raise_on_parsing_error.new, "Could not parse response: #{body}"
      else
        {}
      end
    end
  end

  def success?(response)
    (200...300).cover? response.code.to_i
  end
end
