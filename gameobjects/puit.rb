class Puit < Gameobject  
  GRAVITY = 0.3

  def move_to x, y
    @x = x
    @y = y
  end
  
  def initialize
    super
    self.sprite = :stand_empty
    @vely = 0
  end
  
  def update
    super
    @y += @vely
    
    @vely += GRAVITY
    
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
  
  def jump pressed
    return unless pressed
    if may_jump?
      @vely = -8
    end
  end
  
  def may_jump?
    self.y >= 470 # on_ground
    #maybe if bottom.attached_to != nil
  end
end