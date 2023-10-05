# frozen_string_literal: true

RSpec.describe GhCoab::GhCoab do
  context "#write_coab" do
    it "writes coab" do
      expected_coab = "Co-authored-by: George Kosmopoulos <gkosmo1@hotmail.com>"
      coab = described_class.write_coab("gkosmo")
      expect(coab).to eq([expected_coab])
    end
  end
end
