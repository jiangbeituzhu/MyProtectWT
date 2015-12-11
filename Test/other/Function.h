//
//  Function.h
//  Computer
//
//  Created by yzz on 15/10/20.
//  Copyright (c) 2015年 project. All rights reserved.
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
