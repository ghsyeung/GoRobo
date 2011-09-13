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

r3 = Speedy.new(:x => 0, :y => 0, :direction => 0, :name => 'Sleeper') do
    while(true)
      wait
    end
  end

r4 = Speedy.new(:x => 40, :y => 40, :direction => 0, :name => 'Emery') do
    while(true)
      shoot
      turn -1
      move 1
      turn 1
      move 1
      20.times { shoot }
      turn -1
      move 2
      turn 1
      move 2
      20.times { shoot }
    end
  end



World.setup [
  r, r2, r3, r4
]

World.run
