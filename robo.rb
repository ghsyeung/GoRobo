autoload :World, './gorobo/world'
autoload :Rocket, './gorobo/rocket'

w = World.new [
  Rocket.new(:x => 0, :y => 0, :direction => 180),
  Rocket.new(:x => 0, :y => 10, :direction => 0)
]

w.run