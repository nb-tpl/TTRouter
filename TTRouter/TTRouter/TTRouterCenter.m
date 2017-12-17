//
//  TTRouterCenter.m
//  TTNativeRouter
//
//  Created by 谭鄱仑 on 16/4/11.
//  Copyright © 2016年 谭鄱仑. All rights reserved.
//

#import "TTRouterCenter.h"
@implementation TTAction

@end




@interface TTRouterCenter ()

@property (nonatomic, strong)NSMutableDictionary *nameActionMapping;
@property (nonatomic, strong)NSMutableDictionary *nameControllerMapping;

@end

@implementation TTRouterCenter
@synthesize nameActionMapping,nameControllerMapping;

+(TTRouterCenter *)defaultCenter
{
    static TTRouterCenter * defaultCenter;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        defaultCenter = [TTRouterCenter new];
    });
    return defaultCenter;
}

-(instancetype)init
{
    self = [super init];
    if (self){
        self.nameActionMapping = [NSMutableDictionary new];
        self.nameControllerMapping = [NSMutableDictionary new];
    }
    return self;
}


-(void)addName:(NSString *)name controller:(__kindof UIViewController *(^)(void))controller action:(void (^)(__kindof UIViewController * , __kindof NSDictionary *,BOOL,__kindof UINavigationController *,TTRedirectType))action
{
    self.nameActionMapping[name] = action;
    self.nameControllerMapping[name] = controller;
}

-(TTAction *)actionForName:(NSString *)name
{
    if(![self.nameControllerMapping objectForKey:name]) return nil;
    TTAction * action = [TTAction new];
    action.viewController = self.nameControllerMapping[name];
    action.action = self.nameActionMapping[name];
    
    return action;
}

- (UIViewController *)actionVCForRedirect:(NSString *)name;
{
    return ((__kindof UIViewController *(^)(void))self.nameControllerMapping[name])();
}

@end
