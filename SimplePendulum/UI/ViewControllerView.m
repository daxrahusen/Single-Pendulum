//
//  ViewControllerView.m
//  SimplePendulum
//
//  Created by Dax Rahusen on 21/02/2021.
//  Copyright © 2021 Dax Rahusen. All rights reserved.
//

#import "ViewControllerView.h"

#import "PendulumView.h"

@implementation ViewControllerView {
    
    PendulumView *_pendulum;
}

- (instancetype)init
{
    self = [super initWithFrame:CGRectZero];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        _pendulum = [[PendulumView alloc] init];
        [self addSubview:_pendulum];
        
        //
        // Layout
        //
        NSDictionary *views = NSDictionaryOfVariableBindings(_pendulum);
        
        [NSLayoutConstraint activateConstraints:[NSLayoutConstraint
            constraintsWithVisualFormat:@"H:|-0-[_pendulum]-0-|"
            options:0 metrics:nil views:views
        ]];
        [NSLayoutConstraint activateConstraints:[NSLayoutConstraint
            constraintsWithVisualFormat:@"V:|-0-[_pendulum]-0-|"
            options:0 metrics:nil views:views
        ]];
        
    }
    return self;
}

+ (BOOL)requiresConstraintBasedLayout {
    return YES;
}

@end
