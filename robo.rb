autoload :World, './gorobo/world'
autoload :Robot, './gorobo/robot'
require './gorobo/types'

r = Speedy.new(:x => 0, :y => 0, :direction => 0, :name => 'Sleeper') do
    while(true)
      wait
    end
  end

r2 = Speedy.new(:x => 0, :y => 10, :direction => 0, :name => 'Killer') do
    while(true)
      shoot
    end
  end

r3 = Speedy.new(:x => 30, :y => 0, :direction => 180, :name => 'Grrl') do
    while(true)
			move(1)
			turn(-1)
			shoot
    end
  end


World.setup [
  r, r2, r3
]

World.run
