//
//  TTRouterCenter.h
//  TTNativeRouter
//
//  Created by 谭鄱仑 on 16/4/11.
//  Copyright © 2016年 谭鄱仑. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSUInteger, TTRedirectType) {
    TTRedirectTypePresent = 0,//present跳转
    TTRedirectTypeNavi//navi跳转
};

@interface TTAction : NSObject


@property(nonatomic,strong)NSDictionary * params;

@property(nonatomic,copy)__kindof UIViewController * (^viewController)(void);
@property(nonatomic,copy)void *(^action)(__kindof UIViewController *controller ,__kindof NSDictionary * params,BOOL animated,__kindof UINavigationController * navC, TTRedirectType redirectType);

@end



@interface TTRouterCenter : NSObject

/**
 获取路由控制中心对象

 @return 单例路由控制中心
 */
+(TTRouterCenter *)defaultCenter;

/**
 添加一条路由信息

 @param name 路由标识字符串
 @param controller 路由对应对象生成块
 @param action 路由对象视图控制器跳转行为代码块
 */
- (void)addName:(NSString *)name
     controller:(__kindof UIViewController *(^)(void))controller
         action:(void(^)(__kindof UIViewController *controller ,__kindof NSDictionary * params ,BOOL animated,__kindof UINavigationController * navC, TTRedirectType redirectType))action;

/**
 *  @author 谭鄱仑, 16-04-12 13:04:51
 *
 *  根据关键字获得该关键字注册的路由信息
 *
 *  @param name 路由关键字
 *
 *  @return 路由行为信息对象
 */
-(TTAction *)actionForName:(NSString *)name;


/**
 通过路由标识符获取路由对象

 @param name 路由标识名
 @return 路由标识对应结果视图控制器
 */
- (UIViewController *)actionVCForRedirect:(NSString *)name;
@end
