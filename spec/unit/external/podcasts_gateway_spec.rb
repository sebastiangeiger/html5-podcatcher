require File.expand_path('../../../../app/external/podcasts_gateway', __FILE__)
require 'rubygems'
require 'bundler/setup'
require 'vcr'

VCR.configure do |c|
  c.cassette_library_dir = 'fixtures/vcr_cassettes'
  c.hook_into :webmock # or :fakeweb
end

describe External::PodcastsGateway do
  describe ".retrieve" do
    subject { External::PodcastsGateway.new(url).retrieve }
    context "with Ruby Rogues feed" do
      let(:url) { "http://rubyrogues.com/feed/" }
      it "should have Ruby Rogues in the title" do
        VCR.use_cassette('ruby_rogues') do
          subject.title.should == "Ruby Rogues"
        end
      end
      it "should have the right number of episodes" do
        VCR.use_cassette('ruby_rogues') do
          subject.episodes.size.should == 65
        end
      end
      it "should have RR 061... as title of the last episode" do
        VCR.use_cassette('ruby_rogues') do
          most_recent = subject.episodes.sort_by{|ep| ep.published_at}.last
          most_recent.title.should == "RR 061 Domain Driven Design (DDD) with David Laribee"
        end
      end
    end
  end
end
