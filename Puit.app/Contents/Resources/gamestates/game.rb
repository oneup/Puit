class Gamestate < Gameobject
  attr_accessor :objects
end

class GameRunning < Gamestate  
  def initialize
    super
    @player = Puit.new
    @player.keys = {Gosu::Button::KbRight => :move_right, Gosu::Button::KbLeft => :move_left, Gosu::Button::KbX => :jump}
    
    @objects = [Background.new, @map = Tilemap.new, @cursor = Mouse.new]  
    @map.add @player
    @map.add Pow.new
  end
  
  def update
    super
    @cursor.move_to(game.mouse_x, game.mouse_y)
  end
end
