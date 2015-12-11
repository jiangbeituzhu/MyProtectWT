//
//  Function.m
//  Computer
//
//  Created by yzz on 15/10/20.
//  Copyright (c) 2015年 project. All rights reserved.
//

#import "Function.h"

@implementation Function

+ (void)saveValue:(id)value forKey:(NSString *)key{
    
    [[NSUserDefaults standardUserDefaults] setValue:value forKey:key];

}

+ (id)getValueForKey:(NSString *)key{

    return [[NSUserDefaults standardUserDefaults]valueForKey:key];

}

+ (UIBarButtonItem *)barButtonTitle:(NSString *)title Image:(NSString *)image Target:(id)target Sel:(SEL)selector{
    
    UIButton *button = [UIButton buttonWithType:  UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 50, 30);
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    
    [button addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc]initWithCustomView:button];
    return barButton;
}

//封装的颜色

@end
