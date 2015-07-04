class JsonMashCoder
  def self.load(data)
    ::Hashie::Mash.new JSON.load(data)
  end

  def self.dump(data)
    JSON.dump data
  end
end
