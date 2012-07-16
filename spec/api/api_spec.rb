ENV['RACK_ENV'] = 'test'
require 'rubygems'
require 'bundler/setup'
require 'app/api/api.rb'
require 'rspec'
require 'rack/test'
require 'vcr'

RSpec.configure do |conf|
  conf.include Rack::Test::Methods
end

VCR.configure do |c|
  c.cassette_library_dir = 'fixtures/vcr_cassettes'
  c.hook_into :webmock # or :fakeweb
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

  describe 'post to /podcasts' do
    subject { post '/api/v1/podcasts', data_hash.to_json }
    context 'with a valid feed url that is not in the database' do
      let(:data_hash) { {"url" => "http://rubyrogues.com/feed/"} }
      before do
        Model::PodcastsGateway.stub(:find_by_url).with(data_hash["url"]).and_return nil
      end
      it 'should return the title of the podcast' do
        VCR.use_cassette('ruby_rogues') do
          subject
        end
        JSON.parse(last_response.body)["title"].should == "Ruby Rogues"
      end
    end
  end

end
