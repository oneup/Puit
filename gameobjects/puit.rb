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
    
    if moving_right?
      @x += 2
    end
  end
  
  def move_right pressed
    @move_right = pressed
  end
    
  def moving_right?
    @move_right
  end
end