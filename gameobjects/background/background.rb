class Background < Gameobject
  def on_collision_with object #_puit
    if object.y > 400
      object.y = 400
    end
  end
end