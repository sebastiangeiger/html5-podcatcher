require File.expand_path('../../../domain_model/db/podcasts_gateway', __FILE__)
require File.expand_path('../../../domain_model/entities/podcast', __FILE__)
require File.expand_path('../../../domain_model/entities/hashable_podcast', __FILE__)
class ListAllPodcasts
  def self.call
    new.call
  end
  def call
    podcasts = Model::PodcastsGateway.all
    podcasts.collect do |podcast|
      podcast.extend Model::HashablePodcast
      podcast.to_hash
    end
  end
end
