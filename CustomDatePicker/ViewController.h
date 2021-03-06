//
//  ViewController.h
//  CustomDatePicker
//
//  Created by dangxy on 16/7/12.
//  Copyright © 2016年 xproinfo.com. All rights reserved.
//
// rgb颜色转换（16进制->10进制）
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define  MAIN_HEIGHT                  [UIScreen mainScreen].bounds.size.height

#define  MAIN_WIDTH                   [UIScreen mainScreen].bounds.size.width

#define MainColor  UIColorFromRGB(0x4887CA)

#define MainGray   UIColorFromRGB(0x333333)

#define LightGray  UIColorFromRGB(0x666666)

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController


@end

