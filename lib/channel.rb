class Channel

  attr_reader :name, :id, :channel_options

  def initialize(name, id, options = {})
    raise ArgumentError if name == nil || name == "" || id == nil || id == ""
    @name = name
    @id = id
    @channel_options = options
  end



end
