
# Sprites can either be
#  .png = non-animated
#  .png + .irb = animated
#
class Sprite
  def initialize(path)
    base = File.join(File.dirname(path), File.basename(path, File.extname(path)))
    configuration = base+".irb"

    if configuration.exists?
      @configuration = eval(configuration.read)
      @width = @configuration[:width]
      @height = @configuration[:height] || -1
      @slowdown = @configuration[:slowdown] || 1
      
      @frames = Gosu::Image.load_tiles(window, base+'.png', @width, @height, false)
      
      @height = @frames.first.height if @height == -1
    else #png, non animated
      @frames = [Gosu::Image.new(window, path)]
      
      @width = @frames.first.width
      @height = @frames.first.height
      @slowdown = 1
    end
    @name = File.basename(path, File.extname(path))

    # non-blurry image scaling
    #@frames.each {|f| f.retrofy }
  end
  
  def button_down(id)
    if id == Gosu::Button::KbEscape
      close
    end
  end
  
  def draw frame, orientation, x,y,z
    #puts "#{@name} #{frame} #{@frames.length} = #{frame%@frames.length}"
    @frames[(frame/@slowdown)%(@frames.length)].draw x,y,z, orientation
  end
  
  def width
    @width
  end
  
  def height
    @height
  end
end