# frozen_string_literal: true

require_relative "gh_client"
class GhService
  class GhClientError < StandardError; end

  attr_reader :client_error_class
  def initialize
    @client_error_class = GhClientError
  end

  def get_emails(username)
    response = client.get_events(username)
    response.map do |event|
      next if event.dig(:payload, :commits).nil?
      event[:payload][:commits].map do |commit|
        commit[:author][:email]
      end
    end.flatten.uniq.compact
  end

  def get_name(username)
    response = client.get_profile(username)
    response[:name]
  end

  private

  def client
    @client ||= GhClient.new
  end
end
