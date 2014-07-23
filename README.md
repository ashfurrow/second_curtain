upload-ios-snapshot-test-case
=============================

If you're using the cool [FBSnapshotTestCase](https://github.com/facebook/ios-snapshot-test-case) to test your iOS view logic, awesome! Even better if you have continuous integration, like on Travis, to automate running those tests!

But, isn't it frustrating that you can't *see* the results of your tests? At best, you'll get this kind of error output:

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

Wouldn't it be awesome if we could upload the failing test snapshots somewhere, so we can see exactly what's wrong? That's what this project is going to do. Once it's finished. 