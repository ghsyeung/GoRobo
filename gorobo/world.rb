module World
  SLEEP_DURATION = 1

  extend self

  attr_reader :robots, :max_x, :max_y

  def setup(robots)
    @robots = robots
    @max_x = 10
    @max_y = 10
  end

  def end_turn
    Fiber.yield
  end

  def run
    while (robots.select{|r| !r.is_a?(Rocket)}.count > 1) do
      puts "\e[H\e[2J"

      robots.each do |r|
        old_location = [r.x, r.y]
        r.run
        detect_collisions(r, old_location)
      end
      @robots = robots.select(&:alive?)

      print_status
      sleep SLEEP_DURATION
    end

    puts "!!!! Winner - #{robots.first.name} !!!!!" if robots.any?
  end

  def rocket (r)
    rocket = Rocket.new(:x => r.x, :y => r.y, :direction => r.direction)
    rocket.run
    robots << rocket
  end

  def print_status
    (@max_y + 1).times do |y|
      (@max_x + 1).times do |x|
        robot = robots.find{|r| r.x == x && r.y == y}
        if robot && robot.is_a?(Robot)
          print "R"
        elsif robot && robot.is_a?(Rocket)
          print "*"
        else
          print "."
        end
      end
      print "\n"
    end

    print "\n\n"
    robots.each do |r|
      puts "#{r.name} - [ Health: #{r.health} | X: #{r.x} | Y: #{r.y} ]"
    end
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