require 'fiber'

class Tank
  attr_reader :health
  attr_reader :x
  attr_reader :name

  def initialize(options, &proc)
    
    @health = options[:health] || 100
    @x = options[:x] || 0
    @name = options[:name]

    @thread = Fiber.new do
      self.instance_eval &proc
    end
  end

  def run
    @thread.resume if @thread.alive?
  end

  def move(dist)
    @x += dist
    turn(2)
  end

  def shoot(other)
    other.hit(10) if x == other.x
    turn(5)
  end

  def wait
    turn(1)
  end

  def hit(amount)
    @health -= amount
  end

  def die
    puts "Oh, the humanity!"
    Fiber.yield
  end

  def dead?
    health <= 0
  end

  def alive?
    !dead?
  end

private
  def turn(amount)
    die if dead?
    print "#{name} [ Location: #{x} | Health: #{health}]\n"
    Fiber.yield
  end
end

turn = 0

tanks = [
  Tank.new(name: "Tortoise") do 
    while(true)
      move 1
    end
  end,
  Tank.new(name: "Skipper") do
    while(true)
      other_tanks = tanks.select{|t| t.name != name && t.alive? }
      if other_tanks.empty?
        print "I won!!!\n"
        break
      elsif t = other_tanks.find{|t| t.x == x}
        print "Shooting #{t.name}\n"
        shoot t
      elsif other_tanks.find{|t| t.x > x }
        move 10
      else
        wait
      end
    end
  end,
  Tank.new(name: "Spaz") do
    while (alive?)
      r = rand(10)
      r > 5 ? move(2) : wait
    end
  end
]

while (tanks.count > 1) do
  tanks.each(&:run)
  tanks = tanks.select(&:alive?)
  sleep 0.1
end

puts "!!!! Winner - #{tanks.first.name} !!!!!"