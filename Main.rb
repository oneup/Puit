# Do not include gosu.bundle into this template.
# This is just here so you can run your game from the terminal, or
# your favorite text editor, using `ruby Main.rb`.

require "rubygems" rescue nil
require 'gosu'

require "lib/require_all"
require_all "lib/**/*.rb"
require_all "gameobjects/**/*.rb"


def game
  $game
end

class MyWindow < Gosu::Window
  def initialize
    super 640, 480, false
    $game = self
    self.caption = "Puit"
    @objects = [@cursor = Mouse.new, Puit.new]
  end
  
  def update
    @objects.each_send :update
    
    @cursor.move_to(mouse_x, mouse_y) if @cursor
  end
  
  def draw
    @objects.each_send :draw
  end
end


MyWindow.new
game.show