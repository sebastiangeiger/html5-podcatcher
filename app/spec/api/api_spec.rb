ENV['RACK_ENV'] = 'test'
require 'api/api.rb'
require 'rspec'
require 'rack/test'

RSpec.configure do |conf|
  conf.include Rack::Test::Methods
end

describe 'The API' do
  def app
    Sinatra::Application
  end

  describe 'get on /podcasts' do
    subject { get '/api/v1/podcasts' }
    context 'when no podcasts are in the system' do
      before { Model::PodcastsGateway.stub(:all).and_return( [] ) }

      it 'should return ok' do
        subject
        last_response.should be_ok
      end

      it 'should return json content type' do
        subject
        last_response.content_type.should include("application/json")
      end

      it 'should return an empty json array' do
        subject
        JSON.parse(last_response.body).should == []
      end

      it 'should return an empty json array' do
        subject
        JSON.parse(last_response.body).should == []
      end
    end

    context 'with one podcast in the system' do
      let(:podcast) { Model::Podcast.new }
      before { Model::PodcastsGateway.stub(:all).and_return( [ podcast ] ) }
      it 'should return an empty json array' do
        subject
        JSON.parse(last_response.body).should == [podcast]
      end
    end

  end

  # describe 'post to /podcasts' do
  #   it 'should create the Podcast model' do
  #     hash = {"name" => "some name", "description" => "podcast #1"}
  #     Podcast.should_receive(:create).with(data_hash)
  #     request '/api/v1/podcasts', :method => :post, :input => data_hash.to_json
  #   end
  # end

end
