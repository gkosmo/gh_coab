require_relative "gh_service"
module GhCoab
  class GhCoab
    COAB = "Co-authored-by: "
    def self.write_coab(username)
      name = service.get_name(username)
      emails = service.get_emails(username)
      coabs = emails.map do |email|
        "#{COAB}#{name} <#{email}>"
      end
      puts coabs.join("\n")
      coabs
    end

    def self.service
      @service ||= GhService.new
    end
  end
end
