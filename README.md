upload-ios-snapshot-test-case
=============================

[![Build Status](https://travis-ci.org/AshFurrow/upload-ios-snapshot-test-case.svg?branch=master)](https://travis-ci.org/AshFurrow/upload-ios-snapshot-test-case)

If you're using the cool [FBSnapshotTestCase](https://github.com/facebook/ios-snapshot-test-case) to test your iOS view logic, awesome! Even better if you have continuous integration, like on Travis, to automate running those tests!

Purpose
----------------

Isn't it frustrating that you can't *see* the results of your tests? At best, you'll get this kind of error output:

```
ASHViewControllerSpec
  a_view_controller_with_a_loaded_view_should_have_a_valid_snapshot, expected a matching snapshot in a_view_controller_with_a_loaded_view_should_have_a_valid_snapshot
  /Users/travis/build/AshFurrow/upload-ios-snapshot-test-case/Demo/DemoTests/DemoTests.m:31
  
        it(@"should have a valid snapshot", ^{
            expect(viewController).to.haveValidSnapshot();
        });
  
    Executed 1 test, with 1 failure (1 unexpected) in 0.952 (0.954) seconds
** TEST FAILED **
```

Wouldn't it be awesome if we could upload the failing test snapshots somewhere, so we can see exactly what's wrong? That's what we aim to do here. 

Project Status
----------------

Still very in the early stages – a proof of concept, really. I'll be polishing it up and publishing as a ruby gem shortly. 

Usage
----------------

Usage is pretty simple. I use a Makefile to build and run tests on my iOS project, so my `.travis.yml` file looks something like this:

```
language: objective-c
cache: bundler

env:
  - UPLOAD_IOS_SNAPSHOT_BUCKET_NAME=static.ashfurrow.com
  - UPLOAD_IOS_SNAPSHOT_BUCKET_PREFIX=an/optional/prefix
  - AWS_ACCESS_KEY_ID=ACCESS_KEY
  - AWS_SECRET_ACCESS_KEY=SECRET_KEY

before_install:
  - bundle install

before_script:
  - export LANG=en_US.UTF-8
  - make ci

script:
  - make test
```

Take a look at how to [encrypt information in your config file](http://docs.travis-ci.com/user/encryption-keys/).

My Makefile looks like this:

```
WORKSPACE = Demo/Demo.xcworkspace
SCHEME = Demo

all: ci

build:
	set -o pipefail && xcodebuild -workspace $(WORKSPACE) -scheme $(SCHEME) -sdk iphonesimulator build | xcpretty -c

clean:
	xcodebuild -workspace $(WORKSPACE) -scheme $(SCHEME) clean

test:
	set -o pipefail && xcodebuild -workspace $(WORKSPACE) -scheme $(SCHEME) -configuration Debug test -sdk iphonesimulator | upload-ios-snapshot-test-case | xcpretty -c --test

ci:	build
```

(Note that we're using [xcpretty](http://github.com/supermarin/xcpretty), as you should, too). 

And finally, our Gemfile:

```
source 'https://rubygems.org'

gem 'cocoapods'
gem 'xcpretty'
gem 'upload-ios-snapshot-test-case', :path => './' #Note: will change once we publish as a proper gem
```

And when any snapshot tests fail, they'll be uploaded to S3 and an HTML page will be generated with links to the images so you can download them. Huzzah!
