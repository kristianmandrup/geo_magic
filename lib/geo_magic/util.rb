module GeoMagic
  module Util #:nodoc:
    def self.extract_point point
      case point
      when Hash
        [ point[:lat] || point[:latitude], point[:long] || point[:longitude] ]      
      when GeoMagic::Point
        [point.latitude, point.longitude]
      when GeoMagic::Location
        [point.latitude, point.longitude]
      when Array
        [point[0], point[1]]
      end 
    end  
      
    def self.extract_points from_point, to_point
      [extract_point(from_point), extract_point(to_point)].flatten.map(&:to_f)
    end      
  end
end

class Array
  def as_map_points
    self.extend GeoMagic::MapPoints
  end
  
  def sort_by_distance
    self.sort_by { |item| get_dist_obj(item).dist }
  end  
end

module GeoMagic
  module MapPoints          
    RAD_PER_DEG = 0.017453293    
    
    def rad
      {:km => 6371, :miles => 3956, :feet => 20895592, :meters => 6371000}                     
    end    
    
    def get_within dist_obj, options = {:precision => :lowest}      
      calc_method = get_proc(options[:precision] || :normal)
      from_loc = get_location options[:from]      

      dist = dist_obj.distance  / (RAD_PER_DEG * rad[dist_obj.unit])

      res = []
      spots = populate_distance(calc_method, from_loc)
      spots.sort_by_distance.select do |item|
        it = get_dist_obj(item)
        if it.dist <= dist
          res << item 
        else 
          break 
        end
      end
      res
    end

    def get_closest number, options = {}
      calc_method = get_proc(options[:precision] || :normal)
      from_loc = get_location options[:from]
      populate_distance(calc_method, from_loc).sort_by_distance[0..number]
    end 

    protected

    def get_dist_obj dist_obj
      return dist_obj if dist_obj.respond_to? :dist
      [:point, :to_point, :location].each do |loc|        
        return dist_obj.send(loc) if dist_obj.respond_to? loc
      end
      raise "Invalid Point object: a valid Point object must either be a sublclass of MapPoint or have a #point #to_point or #location method that returns a MapPoint from which can be calculated a distance"
    end

    def populate_distance calc_method, from_loc
      self.map! do |item|
        dist_item = get_dist_obj(item)
        dist_obj = calc_method.call(from_loc, dist_item)
        dist_item.dist = dist_obj.distance
        item
      end      
    end

    def get_location location                   
      raise ArgumentError, "You must specify a :from location" if !location
      raise ArgumentError, "You must specify a :from location that is a kind of GeoMagic::MapPoint" if !location.kind_of?(GeoMagic::MapPoint)
      location
    end
    
    def get_proc precision
      case precision
      when :low
        Proc.new {|point_a, point_b| ::GeoMagic::Calculate.plane_distance point_a, point_b }
      when :normal
        Proc.new {|point_a, point_b| ::GeoDistance::Haversine.point_distance point_a, point_b }
      when :high
        Proc.new {|point_a, point_b| ::GeoDistance::Vincenty.point_distance point_a, point_b }
      else
        raise ArgumentError, "Unknown precision: #{precision}"
      end
    end
  end
end