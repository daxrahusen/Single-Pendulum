//
//  PendulumView.m
//  SimplePendulum
//
//  Created by Dax Rahusen on 21/02/2021.
//  Copyright © 2021 Dax Rahusen. All rights reserved.
//

#import "PendulumView.h"

@implementation PendulumView {
    
    CGFloat _angle;
    CGFloat _angleVelocity;
    CGFloat _angleAcceleration;
    
    CGFloat _gravity;
    
    NSTimer *_timer;
}

- (instancetype)init
{
    self = [super initWithFrame:CGRectZero];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        self.contentMode = UIViewContentModeRedraw;
        self.translatesAutoresizingMaskIntoConstraints = NO;
        
        _angleVelocity = 0;
        _angleAcceleration = 0;
        
        _angle = -M_PI_4;
        _length = 150;
        _gravity = 0.4;
 
        [[NSNotificationCenter defaultCenter] addObserver:self
            selector:@selector(applicationStateDidChange:)
            name:UIApplicationDidEnterBackgroundNotification
            object:nil
        ];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
            selector:@selector(applicationStateDidChange:)
            name:UIApplicationDidBecomeActiveNotification
            object:nil
        ];
        
        [self updateUI];
    }
    return self;
}

- (void)startTimerIfNeeded {
    
    if (!_timer) {
        
        _timer = [NSTimer
            timerWithTimeInterval:0.02
            target:self
            selector:@selector(updateUI)
            userInfo:nil
            repeats:YES
        ];
        
        [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    }
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self stopTimer];
}

- (void)stopTimer {
    [_timer invalidate];
    _timer = nil;
}

#pragma mark -

- (void)applicationStateDidChange:(NSNotification *)notification {
    [self updateUI];
}

- (void)updateUI {

    BOOL isActive = [UIApplication sharedApplication].applicationState == UIApplicationStateActive;
    
    if (isActive) {
        [self startTimerIfNeeded];
    } else {
        [self stopTimer];
    }
    
    [self setNeedsDisplay];
}

- (void)setLength:(CGFloat)length {
    
    if (_length != length) {
        _length = length;
        [self updateUI];
    }
}

- (void)drawRect:(CGRect)rect {
    
    if (_length < 50) {
        return;
    }
    
    CGFloat force = _gravity * sin(_angle);
    _angleAcceleration = (1 * force) / _length;
    _angleVelocity += _angleAcceleration;
    _angle += _angleVelocity;
    
    /*
    NSLog(@"force: %li", force);
    NSLog(@"angleAcceleration: %li", _angleAcceleration);
    NSLog(@"angleVelocity: %li", _angleVelocity);
    NSLog(@"_angle: %li", _angle);
    */
    
    CGRect b = self.bounds;
    
    CGContextRef c = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(c, 2);
    
    CGPoint startPoint = CGPointMake(
        CGRectGetMidX(b),
        CGRectGetMinY(b) + self.safeAreaInsets.top
    );
    
    CGPoint endPoint = CGPointMake(
       _length * -sin(_angle) + startPoint.x,
       _length * -cos(_angle) + startPoint.y
    );
    
    // Draw line
        
    CGContextMoveToPoint(c, startPoint.x, startPoint.y);
    CGContextAddLineToPoint(c, endPoint.x, endPoint.y);
    
    CGContextStrokePath(c);
    
    // Draw circle
    
    CGSize size = CGSizeMake(30, 30);
    
    CGRect r = CGRectMake(
        endPoint.x - size.width / 2,
        endPoint.y - size.height / 2,
        size.width,
        size.height
    );

    CGContextStrokeEllipseInRect(c, r);
}

@end
