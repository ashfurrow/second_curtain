Gem::Specification.new do |s|
  s.name        = 'second_curtain'
  s.version     = '0.2.2'
  s.licenses    = ['MIT']
  s.summary     = "Upload failing iOS snapshot tests cases to S3."
  s.description	=
  %q{
  If you're using the cool FBSnapshotTestCase to test your iOS view logic, awesome! Even better if you have continuous integration, like on Travis, to automate running those tests!

  Wouldn't it be awesome if we could upload the failing test snapshots somewhere, so we can see exactly what's wrong? That's what this project is going to do. Once it's finished.
  }
  s.authors     = ["Ash Furrow", "Orta Therox"]
  s.homepage	= 'https://github.com/AshFurrow/second_curtain'
  s.email       = 'ash@ashfurrow.com'
  s.files       = `git ls-files`.split($/)
  s.require_paths = ["lib"]
  s.executables = s.files.grep(%r{^bin/}) { |f| File.basename(f) }
  s.add_runtime_dependency 'aws-sdk-v1', '~> 1.52'
  s.add_runtime_dependency 'mustache', '~> 0.99'
end
