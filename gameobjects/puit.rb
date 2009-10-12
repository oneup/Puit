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
      self.sprite = :walk_empty
      @orientation = 1
    elsif moving_left?
      @x -= 2
      self.sprite = :walk_empty
      @orientation = -1
    else
      self.sprite = :stand_empty
    end
  end
  
  def move_right pressed
    @move_right = pressed
  end
    
  def moving_right?
    @move_right
  end
  
  def move_left pressed
    @move_left = pressed
  end
    
  def moving_left?
    @move_left
  end
  
end