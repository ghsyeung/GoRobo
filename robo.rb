autoload :World, './gorobo/world'
autoload :Rocket, './gorobo/rocket'
autoload :Robot, './gorobo/robot'

r = Robot.new(:x => 0, :y => 5, :direction => 0, :name => 'Sleeper') do
    while(true)
      wait
    end
  end

r2 = Robot.new(:x => 0, :y => 10, :direction => 0, :name => 'Killer') do
    while(true)
      shoot
    end
  end

World.setup [
  r, r2
]

World.run