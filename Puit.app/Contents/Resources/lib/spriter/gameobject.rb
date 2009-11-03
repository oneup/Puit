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
    
    if @sprite.nil?
      puts "WARNING: no sprite for #{self.class}"
      @bounds = Rect.new(@x, @y, 0, 0)
    else
      @bounds = Rect.new(@x, @y, @sprite.width, @sprite.height)
    end

    @objects = []

    if self.respond_to? :setup
      self.setup
    end
  end
  
  def sprite= what
    @sprite = @sprites[what]
  end
  
  def update
    #puts "#{self} udpate"
    #puts "  #{@objects}" if @objects
    @age += 1
    self.bounds.x = @x
    self.bounds.y = @y
    
    @objects.each_send :update if @objects

    resolve_collisons
  end
  
  def draw
    @sprite.draw(@age, @orientation, @x,@y,@z) if @sprite
    @objects.each_send :draw if @objects
  end
  
  def keys= keybindings
    @keys = keybindings
    game.register_key_receiver self
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
  
  def bottom
    #p self.bounds.bottom
    self.bounds.bottom
  end
  
  def bottom= value
    self.bounds.bottom= value
    self.y = self.bounds.y
  end
  
  def right
    self.bounds.right
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
  end
end