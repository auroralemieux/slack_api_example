require 'test_helper'

describe SlackApiWrapper do
  before do
    VCR.insert_cassette("slack")
  end

  after do
    VCR.eject_cassette("slack")
  end

  describe "testing self.listChannels(token = nil)" do

    it "can get a list of channels" do
      channels = SlackApiWrapper.listChannels
      channels.must_be_instance_of Array
      channels.each do |channel|
        channel.must_be_instance_of Channel
      end
    end

    it "will return an empty array with a bad token" do
      channels = SlackApiWrapper.listChannels("Bad token")

      channels.must_equal []
    end
  end

  describe "testing self.sendMessage(channel_id, text, username=nil, emoji=nil)" do
    it "can send a message to a valid channel" do
      message = SlackApiWrapper.sendMessage("C557BP9QE", "beautiful testing", "peanutbutter", "joy_cat")

      message["ok"].must_equal true
    end

    it "returns false when sending a message fails" do
      message = SlackApiWrapper.sendMessage("fake", "nope")

      message["ok"].must_equal false
    end

    it "requires a channel and a message" do

    end


  end

  describe "testing self.getChannel(channel_id)" do
    it "can get a channel given a valid channel_id" do

      channel = SlackApiWrapper.getChannel("C396CPYBG")
      channel.name.must_equal "ada-announcements"

    end

    it "raises argerror if no channel_id" do
      proc {channel = SlackApiWrapper.getChannel()}.must_raise ArgumentError
    end

    it "returns false if no response" do
      channel = SlackApiWrapper.getChannel("nope")
      channel.must_equal nil
    end

  end
end
