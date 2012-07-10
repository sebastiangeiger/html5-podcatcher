require 'domain_model/interactors/subscription_service.rb'
require 'domain_model/entities/podcast.rb'

describe SubscriptionService do
  it 'should register a subscription for a podcast-series by a user' do
    user = User.new
    podcast = Podcast.new
    SubscriptionService.subscribe(user, podcast)
    user.should be_subscribed_to podcast
  end
end
