require File.expand_path('../../../../../app/domain_model/interactors/retrieve_feed_service.rb', __FILE__)
require File.expand_path('../../../../../app/domain_model/entities/hashable_podcast.rb', __FILE__)
require File.expand_path('../../../../../app/domain_model/entities/podcast.rb', __FILE__)

describe RetrieveFeedService do
  subject { podcast = RetrieveFeedService.new(url).call }
  context "when called with a valid feed" do
    let(:url) { "http://rubyrogues.com/feed/" }
    context "and that feed is not in the database" do
      let(:podcast) { p = Model::Podcast.new; p.title = "Ruby Rogues"; p }
      before do
        Model::PodcastsGateway.stub(:find_by_url).with(url).and_return nil
        External::PodcastsGateway.stub(:retrieve).with(url).and_return podcast
      end
      it "should be a hash with Ruby Rogues in the title" do
        subject[:title].should == "Ruby Rogues"
      end
    end
  end
end
