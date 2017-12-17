//
//  UIButton+tplAdd.h
//  Look
//
//  Created by 谭鄱仑 on 15/12/8.
//  Copyright © 2015年 谭鄱仑. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (tplAdd)




+ (UIButton *)buttonWithType:(UIButtonType)buttonType touchUpInsideActionBlock:(void (^)(id sender))actionBlock;







#pragma test
+ (UIButton *)testButtonWithType:(UIButtonType)buttonType inView:(UIView *)view touchUpInsideActionBlock:(void (^)(id sender))actionBlock;



@end
