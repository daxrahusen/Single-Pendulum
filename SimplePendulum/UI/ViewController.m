//
//  ViewController.m
//  SimplePendulum
//
//  Created by Dax Rahusen on 21/02/2021.
//  Copyright © 2021 Dax Rahusen. All rights reserved.
//

#import "ViewController.h"

#import "ViewControllerView.h"

@interface ViewController ()

@end

@implementation ViewController {
    ViewControllerView __weak *_view;
}

- (id)init { return [super initWithNibName:nil bundle:nil]; }

- (void)loadView {

    ViewControllerView *v = [[ViewControllerView alloc] init];
    self.view = _view = v;
}


@end
