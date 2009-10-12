# powered by Gosy Mac Bundle 0.7.15

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
    @player.keys = {Gosu::Button::KbRight => :move_right, Gosu::Button::KbLeft => :move_left}
    
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
    for i in (0...@objects.size)
      o1 = @objects[i]
      for k in (i+1)...@objects.size
        o2 = @objects[k]
        if o1.collides_with o2
          o1.on_collision_with o2 if o1.respond_to? :on_collision_with
          o2.on_collision_with o1 if o2.respond_to? :on_collision_with
        end
      end
    end
    #
  end
end


MyWindow.new
game.show
