//
//  Function.h
//  Test
//
//  Created by qianfeng on 15/11/23.
//  Copyright (c) 2015年 wt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface Function : NSObject

//封装 对NSUserDefaults的读取操作

+ (void)saveValue:(id)value forKey:(NSString *)key;
+ (id)getValueForKey:(NSString *)key;

//封装NavigationBar上按钮
+ (UIBarButtonItem *)barButtonTitle:(NSString *)title Image:(NSString *)image Target:(id)target Sel:(SEL)selector;

@end
