class Background < Gameobject
  def on_collision_with object #_puit
    if object.bottom >= 460
      object.bottom = 460
    end
  end
end