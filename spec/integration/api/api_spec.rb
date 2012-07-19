ENV['RACK_ENV'] = 'test'
require 'rubygems'
require 'bundler/setup'
require 'app/app.rb'
require 'rspec'
require 'rack/test'
require 'vcr'

RSpec.configure do |conf|
  conf.include Rack::Test::Methods
end

describe 'The API' do
  def app
    HtmlFivePodcatcher
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
      let(:podcast) { p = Model::Podcast.new; p.title = "Some Title"; p }
      before { Model::PodcastsGateway.stub(:all).and_return( [ podcast ] ) }
      it 'should return one element' do
        subject
        JSON.parse(last_response.body).size.should == 1
      end
        it 'should return a podcast with the title Some Title' do
        subject
        JSON.parse(last_response.body).first["title"] == "Some Title"
      end
    end

  end

  describe 'post to /podcasts' do
    subject { post '/api/v1/podcasts', data_hash.to_json }
    context 'with a valid feed url that is not in the database' do
      let(:url) { "http://rubyrogues.com/feed/" }
      let(:data_hash) { {"url" => url} }
      let(:podcast) { p = Model::Podcast.new; p.title = "Ruby Rogues"; p }
      before do
        Model::PodcastsGateway.stub(:find_by_url).with(url).and_return nil
        External::PodcastsGateway.stub(:retrieve).with(url).and_return podcast
      end
      it 'should return the title of the podcast' do
        subject
        JSON.parse(last_response.body)["title"].should == "Ruby Rogues"
      end
    end
  end

end
