# powered by Gosy Mac Bundle 0.7.15

# Do not include gosu.bundle into this template.
# This is just here so you can run your game from the terminal, or
# your favorite text editor, using `ruby Main.rb`.

require "rubygems" rescue nil
require 'gosu'
require "socket"
    
require "lib/require_all"
require_all "lib/**/*.rb"
require_all "gameobjects/**/*.rb"
require_all "maps/**/*.rb"
require_all "gamestates/**/*.rb"


def window
  $game
end

def game
  $game
end


class MyWindow < Gosu::Window
  attr_accessor :key_receivers

  def initialize
    super 640, 320, false
    $game = self
    

    self.caption = "Puit"

    @key_receivers = []  # objects that receive key events. should bubble through the hierachy? (event subsystem)

    @keys = { Gosu::Button::KbEscape => :close,
              Gosu::Button::KbK => :spawn,
              Gosu::Button::KbC => :clear,
              Gosu::Button::KbR => :reset }
              
    reset
    
    Thread.new do
      server_connect
    end
  end
  
  def reset
    @gamestate = GameRunning.new
  end

  def clear
    @gamestate = Gamestate.new
  end
  
  def spawn
    p = Puit.new
    @gamestate.objects << p
    p.x, p.y =  mouse_x, mouse_y
  end
    
  # refactor to superclass
  def update
    super
    @gamestate.update
  end
  
  def draw
    @gamestate.draw
    super
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

  def register_key_receiver object
    @key_receivers << object
  end
  
  def server_connect
    host = 'http://www.libgosu.org'     # The web server
    path = "/index.htm"                 # The file we want 

    socket = TCPSocket.open(host, 80)
    socket.print("GET #{path} HTTP/1.0\r\n\r\n")
    response = socket.read              # Read complete response
    # Split response at first blank line into headers and body
    headers,body = response.split("\r\n\r\n", 2) 
 
    self.caption = body[0...80]
  end
end


MyWindow.new
game.show
