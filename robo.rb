autoload :World, './gorobo/world'
autoload :Robot, './gorobo/robot'
require './gorobo/types'

r = Speedy.new(:x => 0, :y => 0, :direction => 90, :name => 'Ryan') do
  def align(r)
    if r.x == x 
      if (r.y < y)
        while (direction != 0)
          r.turn(1)
        end
      else
        while (direction != 180)
          r.turn(1)
        end
      end
    elsif r.y == y
      if (r.x < x)
        while (direction != 90)
          r.turn(1)
        end
      else
        while (direction != 270)
          r.turn(1)
        end
      end
    end
  end

  move(5)
  turn(1)
    
  while (true) do
    move(1)
    if (target = World.robots.find{|r| (r.x == x || r.y == y) && !r.is_a?(Rocket) && r != self})
      align(target)
      3.times { self.shoot }
    end
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
<<<<<<< HEAD
=======
  end
>>>>>>> 223c5aa604c09ae2805fad86aa756e4127fa666c
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
