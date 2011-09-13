require 'fiber'

class Robot

  attr_reader :health, :x, :y, :name, :direction

  def initialize(options={}, &proc)
    opt = options.dup
    # @health = opt[:health] || 100
    @x = opt[:x] || 0
    @y = opt[:y] || 0
    @direction = opt[:direction]
    @name = opt[:name]

    @thread = Fiber.new do
      self.instance_eval &proc
    end
  end

  def run
    @thread.resume if @thread.alive?
  end

  def move(dist)
    dist = @max_dist if dist > @max_dist
    dist.times do
      case @direction
      when 0
        @y -= dist
      when 90
        @x += dist
      when 180
        @y += dist
      when 270
        @x -= dist
      else
        raise "That direction is an invalid."
      end
      break if World.detect_collision
    end
    
    end_round
  end
  
  def turn(dir)
    if [1,-1].include?(dir)
      @direction += dir*90
      @direction = 270 if @direction == -90
      @direction = 0 if @direction == 360
    else
      raise "You can only turn in 90-degree turning turns."
    end
    end_round
  end
  
  def collide(options={})
    opt = options.dup
    self.hit(opt[:damage])
    if opt[:new_location]
      @x = opt[:new_location].first
      @y = opt[:new_location].last
    end
  end

  def shoot
    World.rocket(self)
    end_round
  end

  def wait
    end_round
  end

  def hit(amount)
    @health -= amount
  end

  def dead?
    health <= 0
  end

  def alive?
    !dead?
  end

protected
  attr_writer :health, :x, :y, :name, :direction, :max_dist, :strength

private
  def end_round
    die if dead?
    Fiber.yield
  end
  
  def die
    print "#{name} exclaims: 'Oh, the humanity!'"
  end
end