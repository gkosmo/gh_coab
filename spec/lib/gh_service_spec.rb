# frozen_string_literal: true

RSpec.describe GhService do
  context "#get_emails" do
    it "gets emails" do
      expected_emails = ["gkosmo1@hotmail.com"]
      emails = described_class.new.get_emails("gkosmo")
      expect(emails).to be_an(Array)
      expect(emails).to eq(expected_emails)
    end
  end

  context "#get_name" do
    it "gets name" do
      expected_name = "George Kosmopoulos"
      name = described_class.new.get_name("gkosmo")
      expect(name).to eq(expected_name)
    end
  end
end
