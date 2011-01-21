# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{geo_magic}
  s.version = "0.2.2.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Kristian Mandrup"]
  s.date = %q{2011-01-21}
  s.description = %q{Get IP and location data using freegeoip.net - can also  calculate of distance between map points using haversine supporting multiple distance units}
  s.email = %q{kmandrup@gmail.com}
  s.extra_rdoc_files = [
    "LICENSE.txt",
    "README.textile"
  ]
  s.files = [
    ".document",
    ".rspec",
    "Gemfile",
    "Gemfile.lock",
    "LICENSE.txt",
    "README.textile",
    "Rakefile",
    "VERSION",
    "geo_magic.gemspec",
    "lib/geo_magic.rb",
    "lib/geo_magic/calculate.rb",
    "lib/geo_magic/distance.rb",
    "lib/geo_magic/geocode/config.rb",
    "lib/geo_magic/geocode/geocoder.rb",
    "lib/geo_magic/location.rb",
    "lib/geo_magic/map_point.rb",
    "lib/geo_magic/meta.rb",
    "lib/geo_magic/point.rb",
    "lib/geo_magic/radius.rb",
    "lib/geo_magic/rectangle.rb",
    "lib/geo_magic/remote.rb",
    "lib/geo_magic/util.rb",
    "lib/rails/config.rb",
    "spec/fixtures/config.yaml",
    "spec/geo_magic/calculate_spec.rb",
    "spec/geo_magic/geocoder_spec.rb",
    "spec/geo_magic/include_calc_spec.rb",
    "spec/geo_magic/include_remote_spec.rb",
    "spec/geo_magic/plane_dist_spec.rb",
    "spec/geo_magic/remote_spec.rb",
    "spec/geo_magic/select_nearest_spec.rb",
    "spec/geo_magic/within_rect_spec.rb",
    "spec/spec_helper.rb"
  ]
  s.homepage = %q{http://github.com/kristianmandrup/geo_magic}
  s.licenses = ["MIT"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{Get your IP and location data and calculate distances on the globe}
  s.test_files = [
    "spec/geo_magic/calculate_spec.rb",
    "spec/geo_magic/geocoder_spec.rb",
    "spec/geo_magic/include_calc_spec.rb",
    "spec/geo_magic/include_remote_spec.rb",
    "spec/geo_magic/plane_dist_spec.rb",
    "spec/geo_magic/remote_spec.rb",
    "spec/geo_magic/select_nearest_spec.rb",
    "spec/geo_magic/within_rect_spec.rb",
    "spec/spec_helper.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<geo-distance>, [">= 0.1.0"])
      s.add_runtime_dependency(%q<httparty>, [">= 0.6.0"])
      s.add_development_dependency(%q<rspec>, [">= 2.3.0"])
      s.add_development_dependency(%q<bundler>, ["~> 1.0.0"])
      s.add_development_dependency(%q<jeweler>, ["~> 1.5.2"])
      s.add_development_dependency(%q<rcov>, [">= 0"])
      s.add_runtime_dependency(%q<geo-distance>, [">= 0.1.0"])
      s.add_runtime_dependency(%q<httparty>, [">= 0.6.0"])
    else
      s.add_dependency(%q<geo-distance>, [">= 0.1.0"])
      s.add_dependency(%q<httparty>, [">= 0.6.0"])
      s.add_dependency(%q<rspec>, [">= 2.3.0"])
      s.add_dependency(%q<bundler>, ["~> 1.0.0"])
      s.add_dependency(%q<jeweler>, ["~> 1.5.2"])
      s.add_dependency(%q<rcov>, [">= 0"])
      s.add_dependency(%q<geo-distance>, [">= 0.1.0"])
      s.add_dependency(%q<httparty>, [">= 0.6.0"])
    end
  else
    s.add_dependency(%q<geo-distance>, [">= 0.1.0"])
    s.add_dependency(%q<httparty>, [">= 0.6.0"])
    s.add_dependency(%q<rspec>, [">= 2.3.0"])
    s.add_dependency(%q<bundler>, ["~> 1.0.0"])
    s.add_dependency(%q<jeweler>, ["~> 1.5.2"])
    s.add_dependency(%q<rcov>, [">= 0"])
    s.add_dependency(%q<geo-distance>, [">= 0.1.0"])
    s.add_dependency(%q<httparty>, [">= 0.6.0"])
  end
end

