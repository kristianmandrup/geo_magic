class Class  
  # macro to extend a class with GeoMagic functionality
  def geo_magic api
    case api
    when :calc, :calculate
      include Geo::Calculate # from geo_calc gem
    when :remote
      include GeoMagic::Remote
    end
  end    
end