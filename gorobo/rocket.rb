class Rocket < Robot
  attr_accessor :x, :y, :direction, :alive, :name

  def initialize(options)
    @health = 5
    @max_dist = 20
    @strength = 10
    super
  end

end