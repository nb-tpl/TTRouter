//
//  UIButton+tplAdd.m
//  Look
//
//  Created by 谭鄱仑 on 15/12/8.
//  Copyright © 2015年 谭鄱仑. All rights reserved.
//

#import "UIButton+tplAdd.h"
#import <objc/runtime.h>

char const touchUpInside_Block_key;

@implementation UIButton (tplAdd)

+ (UIButton *)buttonWithType:(UIButtonType)buttonType touchUpInsideActionBlock:(void (^)(id sender))actionBlock
{
    
    UIButton * button = [UIButton buttonWithType:buttonType];
    [button addTarget:button action:@selector(touchUpInside:) forControlEvents:UIControlEventTouchUpInside];
    objc_setAssociatedObject(button, &touchUpInside_Block_key, actionBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
    
    
    return button;
}


- (void)touchUpInside:(id)sender
{
    void (^actionBlock)(id sender) = objc_getAssociatedObject(sender, &touchUpInside_Block_key);
    actionBlock(sender);
}



#pragma test
+ (UIButton *)testButtonWithType:(UIButtonType)buttonType inView:(UIView *)view touchUpInsideActionBlock:(void (^)(id sender))actionBlock
{
    UIButton * button = [UIButton buttonWithType:buttonType touchUpInsideActionBlock:actionBlock];
    button.frame = CGRectMake(0, 0, 100, 50);
    [button setTitle:@"test" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    button.center = view.center;
    [view addSubview:button];
    return button;
}


@end
