class Array
  def each_send what
    self.each do |e|
      e.send what
    end
  end
end


class Object
  def to_yml(f)
    File.open(f, "w") do |e|
      e.write self.to_yaml
    end
    self # return self so we can continue using that
  end
end
    


def load_image(name)
  Gosu::Image.new(game, name)
end

def scatter(measure) # @to named_fractions
  randomly_between(-measure..measure)
end


class String
  def png
    file_name = self
    $images ||= {}
    $images[file_name] ||= Gosu::Image.new(game, file_name)
  end
  def yml
    $yaml ||= {}
    $yaml[self] ||= YAML.load_file(self) rescue nil
  end

  def from_yml
    yml
  end

  def draw(x,y,z)
    file_name = self
    $images ||= {}                               # level 1 ca$h
    $images[file_name] ||= load_image(file_name) # level 2 ca$h ca$hed loaRDing
  end
  
  def font(size=20)
    cache_name = self + size.to_s
    font_name = self
    $fonts ||= {}
    $fonts[cache_name] ||= Gosu::Font.new(game, font_name, size)
  end

  def play()
    cache_name = self
    $songs ||= {}
    $songs[cache_name] ||= Gosu::Sample.new($game, cache_name)
    $songs[cache_name].play
  end
  
  def require # full directory wide require
    Dir.glob(self).sort.reverse.each do |e|
      require e
    end
  end
  
  def exists?
    FileTest.exist? self
  end

  def read
    File.open(self) do |f|
      return f.read
    end
  end
  
  def method_missing(method, *args) # and resend that method to that object
    # INSTANT PWNZORING
    # when unknown method, assume it an image or sound
    # turns all strings into sound/image file system objects
    $cache ||= {}
    $cache[self] = Gosu::Image.new($game, self) rescue Gosu::Sample.new($game, self)
    $cache[self].send method, args
    #  "resources/sprites/bla.png".draw(0,0)
  end  
end
