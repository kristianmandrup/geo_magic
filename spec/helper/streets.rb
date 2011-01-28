module Streets
  def self.load city
    country_code = country_code_of(city)
    city = city.to_s
  
    @streets ||= {}
    filename = File.join(SPEC_DIR, "fixtures/streets.#{country_code}.yml") # File.expand_path("./../fixtures/streets.#{country_code}.yml", __FILE__)
    @streets[city] ||= begin
      yml = YAML.load_file(filename)
      yml[country_code.to_s][city.to_s]
    rescue
      puts "No key found for city: #{city} in #{filename}"
      []
    end
  end    

  # Move away!
  def self.country_code_of city = :munich
    COUNTRY_CODES[city.to_s.downcase.to_sym]
  end      

  COUNTRY_CODES = {
    :munich     => :de,
    :vancouver  => :ca
  }  
end