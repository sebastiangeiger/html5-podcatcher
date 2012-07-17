module Model
module HashablePodcast
  def to_hash
    {:title => self.title} #TODO: Metaprogramming here!
  end
end
end
