Gem::Specification.new do |s|
  s.name = %q{phtwitvid}
  s.version = "0.1.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["pH (Pedro Henrique Cavallieri Franceschi)"]
  s.date = %q{2009-09-12}
  s.default_executable = %q{phtwitvid}
  s.description = %q{A Library for TwitVid integration written in Ruby.}
  s.homepage = %q{http://www.iBlogeek.com}
  s.email = ["pedrohfranceschi@gmail.com"]
  s.files = ["phtwitvid.gemspec","lib/phtwitvid.rb"]
  s.require_paths = ["lib"]
  s.summary = %q{A Library for TwitVid integration written in Ruby.}
  
  if s.respond_to? :specification_version then
      current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
      s.specification_version = 2

      if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
        s.add_runtime_dependency(%q<httparty>, [">= 0.4.3"])
        s.add_runtime_dependency(%q<xml-simple>, [">= 1.0.12"])
        s.add_runtime_dependency(%q<mechanize>, [">= 0.9.3"])
      else
        s.add_dependency(%q<httparty>, [">= 0.4.3"])
        s.add_dependency(%q<xml-simple>, [">= 1.0.12"])
        s.add_dependency(%q<mechanize>, [">= 0.9.3"])
      end
    else
      s.add_dependency(%q<httparty>, [">= 0.4.3"])
      s.add_dependency(%q<xml-simple>, [">= 1.0.12"])
      s.add_dependency(%q<mechanize>, [">= 0.9.3"])
    end
    
end