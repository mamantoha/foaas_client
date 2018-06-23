require "./spec_helper"

describe Foaas::Client do
  it "works" do
    client = Foaas::Client.new
    client.rtfm("Me").should eq("Read the fucking manual! - Me")
  end
end
