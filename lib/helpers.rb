class Array
  def each_send what
    self.each do |e|
      e.send what
    end
  end
end