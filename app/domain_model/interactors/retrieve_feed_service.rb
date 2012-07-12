class RetrieveFeedService
  def self.call(url)
    new(url).call
  end

  def initialize(url)
    @url = url
  end

  def call

  end

end
