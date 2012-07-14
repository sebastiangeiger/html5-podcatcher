require File.expand_path('../../../domain_model/entities/subscription', __FILE__)
require File.expand_path('../../../domain_model/entities/user.rb', __FILE__)
require File.expand_path('../../../domain_model/db/subscription_gateway.rb', __FILE__)

module Subscriber
  def subscribe_to(podcast)
    subscription = Subscription.new(self,podcast)
    SubscriptionGateway.create(subscription)
  end
  def subscribed_to?(podcast)
    SubscriptionGateway.find(:user => self, :podcast => podcast).any?
  end
end

class SubscriptionService
  def self.subscribe(user,podcast)
    user.extend Subscriber
    user.subscribe_to(podcast)
  end
end
