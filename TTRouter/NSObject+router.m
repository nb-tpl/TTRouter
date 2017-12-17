//
//  NSObject+router.m
//  TTRouter
//
//  Created by tiperTan on 2017/12/17.
//  Copyright © 2017年 tiperTan. All rights reserved.
//

#import "NSObject+router.h"
#import "ViewController.h"
#import "TTRouter.h"

@implementation NSObject (router)



+ (void)resigerALL
{
    [TTRouter routerWithName:@"A" controller:^__kindof UIViewController *{
        ViewController * vc = [ViewController new];
        vc.view.backgroundColor = [UIColor colorWithRed:(arc4random()%255)/255.0f green:(arc4random()%255)/255.0f blue:(arc4random()%255)/255.0f alpha:1];
        return vc;
    } action:^(__kindof UIViewController *controller, __kindof NSDictionary *params, BOOL animated, __kindof UINavigationController *navC, TTRedirectType redirectType) {
        if(redirectType == TTRedirectTypePresent) {
            if(navC == nil || ![navC isKindOfClass:[UINavigationController class]]) {
                navC = [[UINavigationController alloc] initWithRootViewController:controller];
            }
            [[TTRouter navigationController] presentViewController:navC animated:animated completion:nil];
        }else {
            [[TTRouter navigationController] pushViewController:controller animated:animated];
        }
    }];
}

@end
