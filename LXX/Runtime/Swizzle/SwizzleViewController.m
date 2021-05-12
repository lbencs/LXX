//
//  SwizzleViewController.m
//  CookBook
//
//  Created by lben on 2020/8/6.
//  Copyright © 2020 lben. All rights reserved.
//

#import "SwizzleViewController.h"

@interface SwizzleViewController ()

@end

@implementation SwizzleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    NSLog(@"%@--> cmd 3 %@", self, NSStringFromSelector(_cmd));
    [super viewWillAppear:animated];
    NSLog(@"%@--> cmd 4 %@", self, NSStringFromSelector(_cmd));
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
