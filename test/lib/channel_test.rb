require 'test_helper'

describe "Channel" do

  it "requires 2 arguments to initialize" do
    proc {
      Channel.new
    }.must_raise ArgumentError

    proc {
      Channel.new("name")
    }.must_raise ArgumentError
  end

  it "can create a Channel instance" do
    channel = Channel.new("Name", "id")

    channel.class.must_equal Channel

  end

  it "can create a channel with optional params" do
    opt_params = {"members"=>["bob", "sally"]}
    channel = Channel.new("name", "id", opt_params)

    channel.class.must_equal Channel
  end

  it "has the accessor methods" do
    opt_params = {"members"=>["bob", "sally"]}
    channel = Channel.new("name", "id", opt_params)

    channel.channel_options.must_equal opt_params
    channel.name.must_equal "name"
    channel.id.must_equal "id"

  end


end
