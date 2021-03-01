//
//  PendulumView.h
//  SimplePendulum
//
//  Created by Dax Rahusen on 21/02/2021.
//  Copyright © 2021 Dax Rahusen. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PendulumView : UIView

@property (nonatomic, readwrite) CGFloat length;

- (id)init NS_DESIGNATED_INITIALIZER;

- (id)initWithFrame:(CGRect)frame NS_UNAVAILABLE;
- (id)initWithCoder:(NSCoder *)aDecoder NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
