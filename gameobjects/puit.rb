class Puit < Gameobject  
  def move_to x, y
    @x = x
    @y = y
  end
  
  def initialize
    super
    @sprite = @sprites[:walk_empty]
  end
end