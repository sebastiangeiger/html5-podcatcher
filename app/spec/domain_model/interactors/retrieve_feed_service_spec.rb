require 'domain_model/interactors/retrieve_feed_service.rb'
describe RetrieveFeedService do
  context "when called with a valid feed" do
    let(:url) { "http://rubyrogues.com/feed/" }
    it "should return the title" do
      service = RetrieveFeedService.new(url)
      service.call["title"].should == "Ruby Rogues"
    end
  end
end
