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

r2 = Speedy.new(:x => 0, :y => 10, :direction => 0, :name => 'Killer') do
    while(true)
      shoot
    end
end

World.setup [
  r, r2
]

World.run