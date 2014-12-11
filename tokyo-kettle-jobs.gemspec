# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'tokyo-kettle-jobs/version'

Gem::Specification.new do |gem|
  gem.name          = "tokyo-kettle-jobs"
  gem.version       = TokyoKettleJobs::VERSION
  gem.authors       = ["Dung Nguyen"]
  gem.email         = ["dung.nguyen@tripolis.com"]
  gem.description   = "Kettle jobs"
  gem.summary       = "Kettle jobs"
  gem.homepage      = "https://github.com/TripolisSolutions/tokyo-kettle-jobs.git"

  gem.files = Dir['{lib}/**/*'] + ['Rakefile', 'README.md']
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})

end
