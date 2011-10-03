module World
  SLEEP_DURATION = 0.1

  extend self

  attr_reader :robots, :max_x, :max_y

  def setup(robots)
    @robots = robots
    @max_x = 30
    @max_y = 20
  end

  def end_turn
    Fiber.yield
  end

  def run
    initial_status = print_status
    moves = []

    while (robots.select(&:player?).count > 1) do
      robots.each do |r|
        old_location = [r.x, r.y]
        r.run
        detect_collisions(r, old_location)

        moves << r
      end
      @robots = robots.select(&:alive?)
    end

    { :background => initial_status, :world_width => @max_x, :world_height => @max_y, :moves => moves, :winner => @robots.find(&:player?) }
  end

  def rocket (r)
    rocket = Rocket.new(:x => r.x, :y => r.y, :direction => r.direction) do
      while(true)
        move(5)
      end
    end
    rocket.run
    robots << rocket
  end

  def print_status
    out = ""
    (@max_y + 1).times do |y|
      (@max_x + 1).times do |x|
        robot = robots.find{|r| r.x == x && r.y == y}
        if robot && robot.is_a?(Wall)
          out += "#"
        elsif robot && robot.is_a?(Rocket)
          out += "*"
        else
          out += "."
        end
      end
      out += "\n"
    end

    out += "\n\n"
  end

  def detect_collisions(r, old_location)
    if r.x < 0 || r.y < 0 || r.x > @max_x || r.y > @max_y
      r.collide :damage => 10, :new_location => old_location
      return true
    end

    if other = robots.find { |other| other != r && other.x == r.x && other.y == r.y }
      r.collide :damage => 10, :new_location => old_location
      other.collide :damage => 10
      return true
    end

    return false
  end

private
  attr_writer :robots

end
