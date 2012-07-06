class SubscriptionGateway
  def self.create(subscription)
    @subscriptions ||= []
    @subscriptions << subscription
  end
  def self.find(hash)
    @subscriptions
  end
end
