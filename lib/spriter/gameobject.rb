class Gameobject
  def initialize
    @sprite = "gameobjects/#{self.class.name.downcase}.png".png
    @x = @y = 0
    @z = 0
    # dir.glob classname
  end
  
  def update
  end
  
  def draw
    @sprite.draw(@x,@y,@z)
  end
end