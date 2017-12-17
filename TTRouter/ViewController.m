//
//  ViewController.m
//  TTRouter
//
//  Created by tiperTan on 2017/12/15.
//  Copyright © 2017年 tiperTan. All rights reserved.
//

#import "ViewController.h"

#import "UIButton+tplAdd.h"
#import "TTRouter.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    [self registerRouter];
    
    
    
    [UIButton testButtonWithType:UIButtonTypeCustom inView:self.view touchUpInsideActionBlock:^(id sender) {
        [[TTRouter router] redirect:@"A" params:nil animated:YES navC:nil redirectType:arc4random()%2 == 1 ? TTRedirectTypeNavi:TTRedirectTypePresent];
    }];
    
    
    
}


- (void)registerRouter
{
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
