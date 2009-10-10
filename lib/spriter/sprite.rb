
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
      
      @frames = Gosu::Image.load_tiles(window, base+'.png', @width, @height, false)
    else #png, non animated
      @frames = [Gosu::Image.new(window, path)]
    end
  end
  
  def draw x,y,z
    @frames[0].draw x,y,z
  end
end