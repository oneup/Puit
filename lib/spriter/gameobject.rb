class Gameobject
  def initialize
    # object containment
    @parent = game
    
    # animations
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
        sprite_symbol = File.basename(e, File.extname(e)).to_sym
        sprite = Sprite.new e
        @sprites[sprite_symbol] = sprite
        @sprite = @sprites[sprite_symbol]
      end
      #puts @sprites
    end

    @age = 0    
    @x = @y = 0
    @z = 0
    # dir.glob classname
    
    if self.respond_to? :setup
      self.setup
    end
  end
  
  def update
    @age += 1
  end
  
  def draw
    @sprite.draw(@age, @x,@y,@z)
  end
end