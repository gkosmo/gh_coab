require "thor"
require_relative "gh_coab/gh_coab"
# frozen_string_literal: true

require_relative "gh_coab/version"

module GhCoab
  class Error < StandardError; end

  class CLI < Thor
    desc "show", "Displays the co-author name and emails"
    option :username, aliases: "-u", required: true

    def show
      GhCoab.write_coab(options[:username])
    end
  end
end
