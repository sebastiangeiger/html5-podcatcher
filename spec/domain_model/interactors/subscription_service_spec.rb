require File.expand_path('../../../../app/domain_model/interactors/subscription_service', __FILE__)
require File.expand_path('../../../../app/domain_model/entities/podcast', __FILE__)

describe SubscriptionService do
  it 'should register a subscription for a podcast-series by a user' do
    user = User.new
    podcast = Model::Podcast.new
    SubscriptionService.subscribe(user, podcast)
    user.should be_subscribed_to podcast
  end
end
