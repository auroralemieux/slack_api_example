#require "slack_api_wrapper"
#require "channel"


class HomepagesController < ApplicationController
  def index
    @channels = SlackApiWrapper.listChannels
  end

  def create
    # raise
    response = SlackApiWrapper.sendMessage(params[:channel], params[:message], params[:username], params[:emoji])
    # raise
    if response["ok"]
      # flash[:success] = "Your message '#{params[:message]}' was successfully posted to slack channel #{params[:channel]}"
      redirect_to root_path
    # else
      # flash.now[:failure] = "Your message '#{params[:message]}' could not be posted to slack channel #{params[:channel]} at this time"
      # render :new
    end
  end

  def new
    @channel_name = SlackApiWrapper.getChannel(params[:channel])

    @channel_id = params["channel"]
  end
end
