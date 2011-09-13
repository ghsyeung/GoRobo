class Rocket < Robot

  def initialize(options={},&proc)
    @health = 5
    @max_dist = 20
    @strength = 10
    super
  end

end

###

class FatAss < Robot
  
  def initialize(options={},&proc)
    @health = 200
    @max_dist = 1
    @strength = 10
    super
  end
  
end

###

class Speedy < Robot
  
  def initialize(options={},&proc)
    @health = 60
    @max_dist = 10
    @strength = 10
    super
  end
  
end