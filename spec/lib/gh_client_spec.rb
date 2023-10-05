
RSpec.describe GhClient do
  it "gets a profile" do
    name = "George Kosmopoulos"
    expect(subject.get_profile("gkosmo")).to include(name: name)
  end

  it "gets emails" do
    response = subject.get_events("gkosmo")
    expect(response).to be_an(Array)
    expect(response.first).to be_a(Hash)
    expect(response.first).to include(:payload)
  end
end
