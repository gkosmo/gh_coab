require "thor"
require_relative "gh_coab/gh_coab"
# frozen_string_literal: true

require_relative "gh_coab/version"

module GhCoab
  class Error < StandardError; end

  class CLI < Thor
    desc "show <GH_USERNAME>", "Displays the co-author name and emails"

    option :username, aliases: "-u", required: true, type: :string

    def show
      GhCoab.write_coab(options[:username])
    end
    desc "s <GH_USERNAME>", "Displays the co-author name and emails"
    option :username, aliases: "-u", required: true, type: :string

    alias_method :s, :show
  end
end
