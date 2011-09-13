require 'fiber'

class Robot
  attr_reader :health
  attr_reader :x
  attr_reader :y
  attr_reader :name

  def initialize(options={}, &proc)
    opt = options.dup
    @health = opt[:health] || 100
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
    
    end_round
  end
  
  def turn(dir)
    unless [1,-1].include?(dir)
      @direction += dir*90
      @direction = 270 if @direction = -90
      @direction = 0 if @direction = 360
    else
      raise "You can only turn in 90-degree turning turns."
    end
    end_round
  end
  
  def collide(options={})
    opt = options.dup
    self.hit(opt[:damage])
    @x = opt[:new_location].first
    @y = opt[:new_location].last
  end

  def shoot(other)
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

private
  def end_round
    die if dead?
    print "#{name} [ Location: #{x} | Health: #{health}]\n"
    Fiber.yield
  end
  
  def die
    print "#{name} exclaims: 'Oh, the humanity!'"
  end
end