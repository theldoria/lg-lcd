# -*- encoding: utf-8 -*-
require File.expand_path('../lib/lg-lcd/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["theldoria"]
  gem.email         = ["theldoria@hotmail.com"]
  gem.description   = %q{Ruby binding to the 'Logitech LCD SDK Package'}
  gem.summary       = %q{This binding provides low level access to the LCD of some Logitech products like the G19, G15 or G510}
  gem.homepage      = ""

  gem.name          = "lg-lcd"
  gem.platform      = Gem::Platform::RUBY

  gem.required_ruby_version = '>= 1.9.2'
  gem.required_rubygems_version = '>= 1.3.6'
  gem.add_dependency("ffi", ">= 1.1.5")
  gem.add_dependency('methadone', '~>1.2.1')

  gem.add_development_dependency("cucumber")
  gem.add_development_dependency("aruba")

  gem.files         = Dir['{lib}/**/*.{rb,rake,yml,yaml}', '{ext}/*.dll', '{bin}/*', 'README.md', 'LICENSE']
  gem.executables   = ['lglcd']
  gem.test_files    = Dir['{test}/**/*', '{features}/**/*']
  gem.require_paths = ["lib"]
  gem.version       = LgLcd::VERSION
end
