class Gameobject
  attr_accessor :bounds, :x, :y, :width, :height
  
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
    @orientation = 1
    # dir.glob classname
    
    @bounds = Rect.new(@x, @y, @sprite.width, @sprite.height)

    if self.respond_to? :setup
      self.setup
    end
  end
  
  def sprite= what
    @sprite = @sprites[what]
  end
  
  def update
    @age += 1
  end
  
  def draw
    @sprite.draw(@age, @orientation, @x,@y,@z)
  end
  
  def keys= keybindings
    @keys = keybindings
    game.key_receivers << self
  end
  
  def button_down id
    if @keys[id]
      self.send @keys[id], true
    end
  end
  
  def button_up id
    if @keys[id]
      self.send @keys[id], false
    end
  end
  
  def collides_with object
    self.bounds.collide_rect? object.bounds
  end
end