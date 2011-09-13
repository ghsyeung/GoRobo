autoload :World, './gorobo/world'
autoload :Robot, './gorobo/robot'
require './gorobo/types'

r = Speedy.new(:x => 0, :y => 0, :direction => 0, :name => 'Sleeper') do
    while(true)
      wait
    end
  end

r2 = AidanBot.new(:x => 0, :y => 30, :direction => 0, :name => 'AidanBot') do
    while(true)
      move 15
      turn 1
      move 15
      while(true)
        turn 1
        shoot
      end
    end
  end

World.setup [
  r, r2
]

World.run