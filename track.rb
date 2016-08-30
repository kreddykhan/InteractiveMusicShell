class Track
  attr_accessor :name, :count
  def initialize(name)
    @name = name
    @count = 0
  end

  def incrementCount
    @count += 1
  end
end
