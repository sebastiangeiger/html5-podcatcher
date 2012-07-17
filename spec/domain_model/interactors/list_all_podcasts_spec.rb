require File.expand_path('../../../../app/domain_model/interactors/list_all_podcasts', __FILE__)

describe ListAllPodcasts do
  describe ".call" do
    subject { ListAllPodcasts.call }
    context "with no podcast in the system" do
      before { Model::PodcastsGateway.stub(:all).and_return [] }
      it { should be_empty }
    end
    context "with one podcast in the system" do
      let(:podcast) { p = Model::Podcast.new; p.title = "Some title"; p }
      before { Model::PodcastsGateway.stub(:all).and_return [podcast] }
      its(:size) { should be 1 }
      it "should return a podcast as a hash with the appropriate title" do
        subject.first[:title].should == "Some title"
      end
    end
  end
end
