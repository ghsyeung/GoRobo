class Rocket
  attr_accessor :x, :y, :direction, :alive, :name

  def initialize(options)
    self.x = options[:x] 
    self.y = options[:y] 
    self.direction = options[:direction]
    self.name = options[:name]
    self.alive = true

    @thread = Fiber.new do
      while(true) do
        case direction
        when 0
          self.y -= 1
        when 90
          self.x += 1
        when 180
          self.y += 1
        when 270
          self.x -= 1
        else
          raise "horrible things have happened"
        end
        Fiber.yield
      end
    end
  end

  def health
    5
  end

  def collide(stuff)
    puts "Dying!"
    self.alive = false
  end

  def alive?
    alive
  end

  def run
    @thread.resume
  end
end