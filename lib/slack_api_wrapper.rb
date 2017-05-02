require 'httparty'

class SlackApiWrapper
  BASE_URL = "https://api.slack.com/api/"

  TOKEN = ENV["SLACK_TOKEN"]

  def self.listChannels(token = nil)
    token ||= TOKEN
    url = BASE_URL + "channels.list?" + "token=#{token}"

    response = HTTParty.get(url)

    channels = []

    if response["channels"]
      response["channels"].each do |channel|
        channels << Channel.new(channel["name"], channel["id"])
      end
    end

    return channels

  end


  def self.sendMessage(channel_id, text, username=nil, emoji=nil)

    url = BASE_URL + "chat.postMessage?" + "token=#{TOKEN}&" + "username=#{username}&" + "icon_emoji=:#{emoji}:&" "channel=#{channel_id}&" + "text=#{text}"
    response = HTTParty.get(url)

    return response

  end

  def self.getChannel(channel_id)
    @channels = SlackApiWrapper.listChannels

    url = BASE_URL + "channels.info?" + "token=#{TOKEN}&" + "channel=#{channel_id}"

    response = HTTParty.get(url)
    if response["channel"]
      return Channel.new(response["channel"]["name"], response["channel"]["id"])
    else
      return nil
    end
  end
end
