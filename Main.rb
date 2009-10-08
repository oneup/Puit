# Do not include gosu.bundle into this template.
# This is just here so you can run your game from the terminal, or
# your favorite text editor, using `ruby Main.rb`.

require "rubygems" rescue nil
require 'gosu'
require "lib/helpers"

class MyWindow < Gosu::Window
  def initialize
    super 640, 480, false
    
    self.caption = "Puit"
    @objects = []
  end
  
  def update
    @objects.each_send :update
  end
end

MyWindow.new.show
