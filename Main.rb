# Do not include gosu.bundle into this template.
# This is just here so you can run your game from the terminal, or
# your favorite text editor, using `ruby Main.rb`.

require "rubygems" rescue nil
require 'gosu'

require "lib/require_all"
require_all "lib/**/*.rb"
require_all "gameobjects/**/*.rb"



def window
  $game
end

def game
  $game
end

class MyWindow < Gosu::Window
  def initialize
    super 640, 480, false
    $game = self
    self.caption = "Puit"
    @objects = [Background.new, @cursor = Mouse.new, Puit.new]
    
    @sprite = Sprite.new "gameobjects/puit/walk_empty.png"
  end
  
  def update
    @objects.each_send :update
    
    if "gameobjects/puit/stand_empty.png".exists?
      @cursor.move_to(mouse_x, mouse_y) if @cursor
    end
  end
  
  def draw
    @objects.each_send :draw
  end
end


MyWindow.new
game.show