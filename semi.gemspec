Gem::Specification.new do |s|
  s.name            = 'semi'
  s.version         = '0.0.1'
  s.date            = '2017-06-16'
  s.summary         = 'Versatile Docker entrypoint script allowing the creation of configuration files from ERB templates'
  s.description     = ''
  s.authors         = ["Gerard Hickey"]
  s.email           = 'hickey@kinetic-compute.com'
  #s.add_runtime_dependency 'erb', '>= 3.2.0'
  s.add_development_dependency 'rake', '~> 11.3.0'
  s.add_development_dependency 'rspec', '>= 3.5.0'
  s.add_development_dependency 'rake-version', '~> 1.0'
  s.add_development_dependency 'fakefs', '~> 0.10.0'
  s.platform        = Gem::Platform::RUBY
  s.require_paths   = [ 'lib' ]
  s.files           = Dir['lib/*'] + Dir['spec/*']
  s.executables     = []
  s.homepage        = 'https://github.com/hickey/docker-port'
end