class Gameobject
  def initialize
    @sprite = "gameobjects/#{self.class.name.downcase}.png".png
    # dir.glob classname
  end
  
  def update
  end
  
  def draw
    @sprite.draw(0,0,0)
  end
end