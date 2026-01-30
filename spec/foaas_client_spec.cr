require "./spec_helper"

describe Foaas::Client do
  client = Foaas::Client.new

  it "operations" do
    Foaas::Client::OPERATIONS.size.should eq(99)
  end

  it "works" do
    message = client.rtfm("Me")

    message.message.should eq("Read the fucking manual!")
    message.subtitle.should eq("- Me")
  end

  it "i18n" do
    message = client.awesome("Everyone", i18n: "uk")
    message.message.should eq("Це, чорт забирай, класно. Усі ")
  end
end
