//
//  TTRouter.h
//  TTNativeRouter
//
//  Created by 谭鄱仑 on 16/4/11.
//  Copyright © 2016年 谭鄱仑. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "TTRouterCenter.h"


#define redirectNameKey @"redirectNameKey"
@interface TTRouter : NSObject


/**
 url跳转解析块，根据不同url解析出本地需要的跳转数据 返回字典需包含跳转标识，对应key为redirectNameKey
 */
@property(nonatomic,copy)__kindof NSDictionary * (^paramsFromURL)(NSString * url);

/**
 *  @author 谭鄱仑, 16-04-12 13:04:56
 *
 *  获得当前的导航控制器，没有则为nil
 *
 *  @return 当前最前面的导航控制器
 */
+(__kindof UINavigationController *)navigationController;

/**
 *  @author 谭鄱仑, 16-04-12 13:04:05
 *
 *  获得路由器对象单例
 *
 *  @return 路由器单例对象
 */
+ (instancetype)router;

/**
 *  @author 谭鄱仑, 16-04-12 13:04:24
 *
 *  向路由中心注册一条关键字路由信息
 *
 *  @param name       路由关键字
 *  @param controller 路由关键字获取的视图控制器
 *  @param action     路由关键字的行为块
 *
 *  @return 路由器单例
 */
+ (instancetype)routerWithName:(NSString *)name
                    controller:(__kindof UIViewController *(^)(void))controller
                        action:(void(^)(__kindof UIViewController *controller , __kindof NSDictionary * params , BOOL animated,__kindof UINavigationController * navC, TTRedirectType redirectType)) action;





/**
 *  @author 谭鄱仑, 16-04-12 13:04:30
 *
 *  判断关键字是否能跳转的方法
 *
 *  @param name 跳转关键字
 *
 *  @return 是否能跳转，是否已注册
 */
- (BOOL)canRedirect:(NSString *)name;

/**
 *  @author 谭鄱仑, 16-04-12 13:04:46
 *
 *  根据关键字定向跳转方法
 *
 *  @param name     跳转关键字
 *  @param params   参数
 *  @param animated 是否动画
 *  @param navC         present方式需要使用的外层navi，可为nil，nil则用默认的navi
 *  @param redirectType 跳转方式
 *
 *  @return 跳转的视图控制器
 */
- (__kindof UIViewController *)redirect:(NSString *)name params:(NSDictionary *)params animated:(BOOL) animated navC:(__kindof UINavigationController *)navC redirectType:(TTRedirectType) redirectType;


/**
 根据url跳转，前提是有url解析的block块，没有返回nil

 @param url 跳转的url
 @param animated 是否动画
 @param navC present方式需要使用的外层navi，可为nil，nil则用默认的navi
 @param redirectType 跳转方式
 @return 跳转的视图控制器
 */
- (__kindof UIViewController *)redirectToURL:(NSString *)url animated:(BOOL) animated navC:(__kindof UINavigationController *)navC redirectType:(TTRedirectType) redirectType;

@end
