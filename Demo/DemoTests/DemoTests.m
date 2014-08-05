//
//  DemoTests.m
//  DemoTests
//
//  Created by Ash Furrow on 2014-07-23.
//  Copyright (c) 2014 Ash Furrow. All rights reserved.
//

#define EXP_SHORTHAND
#import <Specta/Specta.h>
#import <Expecta/Expecta.h>
#import <Expecta+Snapshots/EXPMatchers+FBSnapshotTest.h>

#import <XCTest/XCTest.h>
#import "ASHViewController.h"

SpecBegin(ASHViewController)

describe(@"a view controller", ^{
    __block ASHViewController *viewController;
    beforeEach(^{
        viewController = [[ASHViewController alloc] init];
    });
    
    describe(@"with a loaded view", ^{
        beforeEach(^{
            expect(viewController.view).toNot.beNil();
        });
        
        it(@"should have a valid snapshot", ^{
            expect(viewController).to.haveValidSnapshot();
        });
    });
});

describe(@"views", ^{
    it(@"should be green", ^{
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 320)];
        view.backgroundColor = [UIColor purpleColor];
        expect(view).to.haveValidSnapshot();
    });
    
    it(@"should be red", ^{
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 60, 320)];
        view.backgroundColor = [UIColor orangeColor];
        expect(view).to.haveValidSnapshot();
    });

});


SpecEnd
