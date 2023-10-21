# -*- encoding: utf-8 -*-
# stub: hkdf 1.0.0 ruby lib

Gem::Specification.new do |s|
  s.name = "hkdf".freeze
  s.version = "1.0.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["John Downey".freeze]
  s.date = "2021-04-16"
  s.description = "A ruby implementation of RFC5869: HMAC-based Extract-and-Expand Key Derivation Function (HKDF). The goal of HKDF is\nto take some source key material and generate suitable cryptographic keys from it.\n".freeze
  s.email = ["jdowney@gmail.com".freeze]
  s.homepage = "http://github.com/jtdowney/hkdf".freeze
  s.licenses = ["MIT".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 2.4.0".freeze)
  s.rubygems_version = "3.3.3".freeze
  s.summary = "HMAC-based Key Derivation Function".freeze

  s.installed_by_version = "3.3.3" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4
  end

  if s.respond_to? :add_runtime_dependency then
    s.add_development_dependency(%q<rake>.freeze, ["~> 12.0"])
    s.add_development_dependency(%q<rspec>.freeze, ["~> 3.9"])
    s.add_development_dependency(%q<rubocop>.freeze, ["~> 1.12"])
    s.add_development_dependency(%q<rubocop-rake>.freeze, ["~> 0.5.1"])
    s.add_development_dependency(%q<rubocop-rspec>.freeze, ["~> 2.2"])
  else
    s.add_dependency(%q<rake>.freeze, ["~> 12.0"])
    s.add_dependency(%q<rspec>.freeze, ["~> 3.9"])
    s.add_dependency(%q<rubocop>.freeze, ["~> 1.12"])
    s.add_dependency(%q<rubocop-rake>.freeze, ["~> 0.5.1"])
    s.add_dependency(%q<rubocop-rspec>.freeze, ["~> 2.2"])
  end
end
