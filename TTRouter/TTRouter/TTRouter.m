//
//  TTRouter.m
//  TTNativeRouter
//
//  Created by 谭鄱仑 on 16/4/11.
//  Copyright © 2016年 谭鄱仑. All rights reserved.
//

#import "TTRouter.h"



@implementation TTRouter


+(__kindof UINavigationController *)navigationController
{
    
    UIWindow * window = [UIApplication sharedApplication].keyWindow;
//    //NSLog(@"window = %@",window);
    
    //为了换肤的浮层修改 多维新闻
    UIView *frontView = [[window subviews] lastObject];
    
//    if(frontView.tag == 1000) {
//        frontView = [[window subviews] objectAtIndex:[[window subviews] count] - 2];
//    }
    int i = 1;
    do{
        frontView = [[window subviews] objectAtIndex:[[window subviews] count] - i];
        i++;
    }while(!([frontView isKindOfClass:NSClassFromString(@"UILayoutContainerView")] || [frontView isKindOfClass:NSClassFromString(@"UITransitionView")]));
//UILayoutContainerView  navi
//UITransitionView prsent
//
    //通用采用下面注释的
//    UIView *frontView = [[window subviews] lastObject];
//    //NSLog(@"window.subviews = %@",window.subviews);

    id nextResponder = [frontView nextResponder];
    if ([nextResponder isKindOfClass:[UINavigationController class]]){
        return (UINavigationController *)nextResponder;
    }
    else {
        UIView * frontSubview = frontView.subviews.count > 0 ? [frontView.subviews objectAtIndex:0] : nil;
        if (frontSubview) {
            nextResponder = [frontSubview nextResponder];
            if ([nextResponder isKindOfClass:[UINavigationController class]]) {
                return (UINavigationController *)nextResponder;
            }
        }
        return nil;
    }
}

+ (instancetype)router
{
    static TTRouter * router;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        router = [TTRouter new];
    });
    return router;
}


+ (instancetype)routerWithName:(NSString *)name
                    controller:(__kindof UIViewController *(^)(void))controller
                        action:(void(^)(__kindof UIViewController *controller , __kindof NSDictionary * params ,BOOL animated,__kindof UINavigationController * navC, TTRedirectType redirectType)) action
{
    
    [[TTRouterCenter defaultCenter]addName:name controller:controller action:action];
    return [TTRouter router];
}


- (__kindof UIViewController *)redirect:(NSString *)name params:(NSDictionary *)params animated:(BOOL)animated navC:(__kindof UINavigationController *)navC redirectType:(TTRedirectType)redirectType;
{
    TTAction *action = [[TTRouterCenter defaultCenter] actionForName:name];
    if(!action) return nil;
    UIViewController *controller = action.viewController();
    if(controller && [controller isKindOfClass:[UIViewController class]])
        action.action(controller,params, animated,navC,redirectType);
    return controller;
}

- (__kindof UIViewController *)redirectToURL:(NSString *)url animated:(BOOL) animated navC:(__kindof UINavigationController *)navC redirectType:(TTRedirectType) redirectType
{
    UIViewController * controller = nil;
    if([TTRouter router].paramsFromURL)
    {
        NSDictionary * params = [TTRouter router].paramsFromURL(url);
        if([params isKindOfClass:[NSDictionary class]]) {
          controller = [[TTRouter router] redirect:params[redirectNameKey] params:params animated:animated navC:navC redirectType:redirectType];
        }
    }
    return controller;
}

- (BOOL)canRedirect:(NSString *)name;
{
    if([[TTRouterCenter defaultCenter] actionForName:name]) return YES;
    return NO;
}





@end
