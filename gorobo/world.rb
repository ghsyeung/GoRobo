class World
  SLEEP_DURATION = 0.1

  attr_reader :robots, :max_x, :max_y

  def initialize(robots)
    @robots = robots
    @max_x
    @max_y
  end

  def end_turn
    Fiber.yield
  end

  def run
    while (robots.count > 1) do
      robots.each do |r|
        old_location = [r.x, r.y]
        r.run
        detect_collisions(r, old_location)
      end
      print_status
      @robots = robots.select(&:alive?)
      sleep SLEEP_DURATION
    end

    puts "!!!! Winner - #{robots.first.name} !!!!!" if robots.any?
  end

  def rocket (r)
    robots << Rocket.new(:x => r.x, :y => r.y, :direction => r.direction)
  end

  def print_status
    robots.each do |r|
      puts "#{r.name}: [ Health: #{r.health} | X: #{r.x} | Y: #{r.y} ]"
    end
  end

  def detect_collisions(r, old_location)
    if other = robots.find { |other| other != r && other.x == r.x && other.y == r.y }
      r.collide :damage => 10, :new_location => old_location
      other.collide :damage => 10
    end
  end

private
  attr_writer :robots

end