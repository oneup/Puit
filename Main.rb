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
  attr_accessor :key_receivers

  def initialize
    super 640, 480, false
    $game = self
    
    self.caption = "Puit"

    @key_receivers = []
        
    @player = Puit.new
    @player.keys = {Gosu::Button::KbRight => :move_right}
    
    @objects = [Background.new, @cursor = Mouse.new, @player]

    
    @keys = { Gosu::Button::KbEscape => :close }
  end
  
  def update
    @objects.each_send :update

    @cursor.move_to(mouse_x, mouse_y) if @cursor

    resolve_collisons
  end
  
  def draw
    @objects.each_send :draw
  end
  
  def button_down(id)
    @key_receivers.each do |object|
      object.button_down id
    end

    @keys.each do |button, method|
      if id == button
        self.send method
      end
    end
  end

  def button_up(id)
    @key_receivers.each do |object|
      object.button_up id
    end
  end
  
  def resolve_collisons
    #
  end
end


MyWindow.new
game.show
