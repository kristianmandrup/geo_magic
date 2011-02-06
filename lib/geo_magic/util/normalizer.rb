module GeoMagic
  module Normalizer
    NORMALIZER = 100.0

    def normalize n 
      (n * NORMALIZER).to_i
    end

    def denormalize n
      n / NORMALIZER
    end
  end
end