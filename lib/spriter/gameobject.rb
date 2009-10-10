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
        #animation_config_yml = File.join(File.dirname(path), File.basename(path, ".yml"))
        # make sprite class - sprite can be unanimated or animated image.
        # the missing class from gosu (adding game layer)
        #[ ] the gosu bundle does not support yml - make own format
        @sprites[File.basename(e, File.extname(e)).to_sym] = e.png
        @sprite = e.png
      end
      
      #puts @sprites
    end
    
    @x = @y = 0
    @z = 0
    # dir.glob classname
    
    if self.respond_to? :setup
      self.setup
    end
  end
  
  def update
  end
  
  def draw
    @sprite.draw(@x,@y,@z)
  end
end