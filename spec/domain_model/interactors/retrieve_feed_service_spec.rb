require File.expand_path('../../../../app/domain_model/interactors/retrieve_feed_service.rb', __FILE__)

describe RetrieveFeedService do
  subject { podcast = RetrieveFeedService.new(url).call }
  context "when called with a valid feed" do
    let(:url) { "http://rubyrogues.com/feed/" }
    context "and that feed is not in the database" do
      before do
        Model::PodcastsGateway.stub(:find_by_url).with(url).and_return nil
        External::PodcastsGateway.stub(:retrieve).with(url).and_return stub(:title => "Ruby Rogues")
      end
      its(:title) { should == "Ruby Rogues" }
    end
  end
end
