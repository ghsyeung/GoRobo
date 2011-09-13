class Rocket < Robot
  attr_accessor :x, :y, :direction, :alive, :name

  def initialize(options)
    self.health = 5
    self.max_dist = 20
    self.strength = 10
    super
  end

end