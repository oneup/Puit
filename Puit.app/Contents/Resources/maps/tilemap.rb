class Map < Gameobject
  def initialize
    super
    @objects = []
  end
  
  def children
    @objects
  end
  
  def add object
    @objects << object
  end
end


class Tilemap < Map
  def tile_size
    8
  end

  def initialize 
    super

    @tiles = [[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]]
    @@tile_images ||= ["maps/tiles/floor.png".png]
    
    @x = 0
    @y = 0
    @width = @tiles[0].size * tile_size
    @height = @tiles.size * tile_size
    
    @y = game.height-@height
  end
  
  def bounds
    @bounds = Rect.new(@x, @y, @width, @height)
  end
  
  def bottom
    bounds.bottom
  end
  
  def bottom= value
    bounds.bottom= value
  end
  
  def draw
    super
    x = @x
    y = @y
    z = 0

    @tiles.each do |row|
      row.each do |column|
        @@tile_images[column].draw(x,y,z)
        x += tile_size
      end
      y += tile_size
    end
  end
  
  def update
    super
  end
  
  def resolve_collisons #this isn't perfect
    resolve_tilemap_collisions
    
    super # now resolve the object between each other normally
  end
  
  def collides_with o
    #hmmm
  end
  
  def resolve_tilemap_collisions
    @objects.each do |o|
      # translate object coordinates to tile coordinates
      # check for tile on that position
      
      start_x = o.x - self.x
      start_y = o.y - self.y
      end_x = o.right - self.x
      end_y = o.bottom - self.y
      
      start_x_tile = start_x/tile_size
      start_y_tile = start_x/tile_size
      end_x_tile = end_x/tile_size
      end_y_tile = end_y/tile_size
      
#      if tiles[start_y_tile][start_x_tile] == 1
#        object.bottom = start_y_tile
#      end
    end
  end
end