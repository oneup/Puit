class Puit < Gameobject  
  def move_to x, y
    @x = x
    @y = y
  end
  
  def initialize
    super
    @sprite = @sprites[:walk_empty]
  end
  
  def update
    super
    @y += 2
  end
  
  def move_right
    @x += 2
  end
  
  def keys= keybindings
    # todo
  end
end