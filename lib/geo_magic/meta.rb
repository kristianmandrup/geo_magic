class Class  
  # macro to extend a class with GeoMagic functionality
  def geo_magic api
    case api
    when :calc, :calculate
      include GeoMagic::Calculate
    when :remote
      include GeoMagic::Remote
    end
  end    
end