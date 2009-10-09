class Gameobject
  def initialize
    @sprites = {}
    # simple file
    simple_file = "gameobjects/#{self.class.name.downcase}.png"
    if FileTest.exist? simple_file
      @sprite = simple_file.png
      @sprites[:default] = @sprite
    else
      #directory contents
      Dir.glob("gameobjects/#{self.class.name.downcase}/*.png").collect do |e|
        @sprites[File.basename(e).gsub(".png", "").to_sym] = e.png
        @sprite = e.png
      end
      
      #puts @sprites
    end
    
    @x = @y = 0
    @z = 0
    # dir.glob classname
  end
  
  def update
  end
  
  def draw
    @sprite.draw(@x,@y,@z)
  end
end