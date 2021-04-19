require_relative 'lib/vtt2ass/version'

Gem::Specification.new do |spec|
  spec.name          = "vtt2ass"
  spec.version       = Vtt2ass::VERSION
  spec.authors       = ["Louis-Philippe Fortin"]
  spec.email         = ["timemaster.lpf@gmail.com"]

  spec.summary       = "Convert VTT subtitles to ASS subtitles"
  spec.homepage      = "https://gitlab.com/dkb-weeblets/vtt2ass"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.7.2")

  spec.metadata["allowed_push_host"] = "https://rubygems.org"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency 'htmlentities', '~> 4.3'

  spec.add_development_dependency 'rake', '~> 12.0'
  spec.add_development_dependency 'minitest', '~> 5.0'
  spec.add_development_dependency 'yard', '~> 0.9'
end
