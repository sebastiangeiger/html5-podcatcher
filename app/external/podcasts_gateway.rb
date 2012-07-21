require "open-uri"
require "rubygems"
require "bundler/setup"
require "rpodcast"

module External
  class PodcastsGateway
    def self.retrieve(url)
      new(url).retrieve
    end
    def initialize(url)
      @url = url
    end
    def retrieve
      podcast = RPodcast::Feed.new(get_content)
      podcast.parse
      podcast
    end
    def get_content
      open(@url) {|f| f.read }
    end
  end
end
