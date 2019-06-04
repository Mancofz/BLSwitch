//
//  ViewController.m
//  CustomSwitch
//
//  Created by Manco on 2019/6/4.
//  Copyright © 2019 Manco. All rights reserved.
//

#import "ViewController.h"
#import "BLSwitch/BLSwitch.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    BLSwitch *blswitch = [[BLSwitch alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    blswitch.leftTintTitle = @"开";
    blswitch.rightTintTitle = @"关";
    blswitch.valueChangedBlock = ^(BOOL isOn) {
        NSLog(@"=======%d",isOn);
    };
    [self.view addSubview:blswitch];
}


@end
