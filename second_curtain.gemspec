Gem::Specification.new do |s|
  s.name        = 'second_curtain'
  s.version     = '0.1.1'
  s.licenses    = ['MIT']
  s.summary     = "Upload failing iOS snapshot tests cases to S3."
  s.description	= 
  %q{
  If you're using the cool FBSnapshotTestCase to test your iOS view logic, awesome! Even better if you have continuous integration, like on Travis, to automate running those tests!

  Wouldn't it be awesome if we could upload the failing test snapshots somewhere, so we can see exactly what's wrong? That's what this project is going to do. Once it's finished.
  }
  s.authors     = ["Ash Furrow"]
  s.homepage	= 'https://github.com/AshFurrow/second_curtain'
  s.email       = 'ash@ashfurrow.com'
  s.files       = [
    "lib/second_curtain.rb",
    "lib/second_curtain/upload_manager.rb",
    "lib/second_curtain/upload.rb",
  ]
  s.require_paths = ["lib"]
  s.executables << 'second_curtain'
  s.add_runtime_dependency 'aws-sdk', '~> 1.48'
end
