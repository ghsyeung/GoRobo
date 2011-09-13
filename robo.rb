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

World.setup [
  r, r2
]

World.run