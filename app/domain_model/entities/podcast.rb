module Model
class Podcast
  def to_json(*a)
    {
      "json_class"   => self.class.name
    }.to_json(*a)
  end
  def self.json_create(o)
    new
  end
  def ==(another_podcast)
    true
  end
end
end
