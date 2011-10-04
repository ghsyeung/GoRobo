autoload :World, './gorobo/world'
autoload :Robot, './gorobo/robot'
require './gorobo/types'
require 'active_support'

r = Speedy.new(:x => 15, :y => 15, :direction => 0, :name => 'Ryan') do
  def align(r)
    if r.x == x 
      if (r.y < y)
        while (direction != 0)
          turn(1)
        end
      else
        while (direction != 180)
          turn(1)
        end
      end
    elsif r.y == y
      if (r.x < x)
        while (direction != 270)
          turn(1)
        end
      else
        while (direction != 90)
          turn(1)
        end
      end
    end
  end

  def close_to_wall
    (x <= 1 && direction == 270) ||
    (y <= 1 && direction == 0) ||
    (x >= 29 && direction == 90) ||
    (y >= 29 && direction == 180)
  end

  move(5)
  turn(1)
  move(5)
    
  while (true) do
    if (target = World.robots.find{|r| (r.x == x || r.y == y) && r.player? && r != self})
      align(target)
      3.times { self.shoot }
    else
      if close_to_wall
        turn 1 
        turn 1
        move 5 
      else
        move 1
      end
    end
  end
end

r2 = Speedy.new(:x => 0, :y => 30, :direction => 0, :name => 'AidanBot') do
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

r4 = Speedy.new(:x => 30, :y => 30, :direction => 0, :name => 'Emery') do
  while(true)
    7.times { move 2; turn -1; move 2; turn 1} 
    4.times { shoot; turn 1 }
    4.times { shoot; turn 1 }
  end
end



r3 = Speedy.new(:x => 30, :y => 0, :direction => 180, :name => 'Grrl') do
    while(true)
			move(1)
			turn(-1)
			shoot
    end
  end



walls = (0..30).map { |i| Wall.new(:x => i, :y => 25, :direction => 180, :name => "Wall #{i}") }
#walls << Wall.new(:x => 15, :y => 19, :direction => 180, :name => "Wall to see")
#walls << Wall.new(:x => 14, :y => 19, :direction => 180, :name => "Wall to see")
#walls << Wall.new(:x => 16, :y => 19, :direction => 180, :name => "Wall to see")
#walls << Wall.new(:x => 13, :y => 19, :direction => 180, :name => "Wall to see")
#walls << Wall.new(:x => 17, :y => 18, :direction => 180, :name => "Wall to see")
#walls << Wall.new(:x => 14, :y => 15, :direction => 180, :name => "Wall left")
#walls << Wall.new(:x => 16, :y => 15, :direction => 180, :name => "Wall right")


World.setup [
  r, r2, r3, r4
] + walls

puts World.print_status
r.others.each do |robot|
  puts robot.name
end

#World.interactive_run
