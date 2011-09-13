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

r3 = Speedy.new(:x => 0, :y => 30, :direction => 0, :name => 'Sleeper2') do
  while(true)
    wait
  end
end

r4 = Speedy.new(:x => 30, :y => 30, :direction => 0, :name => 'Emery') do
  while(true)
    7.times { move 2; turn -1; move 2; turn 1} 
    4.times { shoot; turn 1 }
    4.times { shoot; turn 1 }
  end
end



World.setup [
  r, r2, r3, r4
]

World.run
