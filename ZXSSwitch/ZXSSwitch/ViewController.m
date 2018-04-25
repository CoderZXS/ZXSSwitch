//
//  ViewController.m
//  ZXSSwitch
//
//  Created by CoderZXS on 2018/4/25.
//  Copyright © 2018年 CoderZXS. All rights reserved.
//

#import "ViewController.h"
#import "ZXSSwitch.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    ZXSSwitch *myswitch = [[ZXSSwitch alloc] initWithFrame:CGRectMake(200, 200, 80, 31)];
    [self.view addSubview:myswitch];
    [myswitch addTarget:self action:@selector(handleSwitchEvent:) forControlEvents:UIControlEventValueChanged];
    myswitch.backgroundColor = [UIColor clearColor];
    myswitch.onText = @"ON";
    myswitch.offText = @"OFF";

}


- (void)handleSwitchEvent:(ZXSSwitch *)mySwitch {
    NSLog(@"%s", __FUNCTION__);
}


@end
