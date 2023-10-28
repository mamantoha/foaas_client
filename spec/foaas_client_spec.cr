require "./spec_helper"

describe Foaas::Client do
  client = Foaas::Client.new

  it "works" do
    client.rtfm("Me")
      .should eq("Read the fucking manual! - Me")
  end

  it "operations" do
    Foaas::Client::OPERATIONS.size.should eq(99)
  end

  it "accept json" do
    client.rtfm("Me", accept_type: :json)
      .should eq("{\"message\":\"Read the fucking manual!\",\"subtitle\":\"- Me\"}")
  end

  it "accept html" do
    client.rtfm("Me", accept_type: :html)
      .should start_with("<!DOCTYPE html>")
  end

  it "accept xml" do
    client.rtfm("Me", accept_type: :xml)
      .should start_with("<?xml")
  end

  it "accept text" do
    client.rtfm("Me", accept_type: :text)
      .should eq("Read the fucking manual! - Me")
  end
end
