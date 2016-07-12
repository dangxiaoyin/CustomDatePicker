//
//  UIPickerView+malPicker.m
//  medical_hp
//
//  Created by dangxy on 16/6/8.
//  Copyright © 2016年 linakge. All rights reserved.
//

#import "UIPickerView+malPicker.h"
#import <objc/runtime.h>

@implementation UIPickerView (malPicker)

- (void)clearSpearatorLine
{
    if (!self.mal_lineisHidden)
    {
        [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            if (obj.frame.size.height < 1)
            {
                obj.backgroundColor = [UIColor clearColor];
            }
        }];
    }
    self.mal_lineisHidden = YES;
}

- (BOOL)mal_lineisHidden
{
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

- (void)setMal_lineisHidden:(BOOL)mal_lineisHidden
{
    objc_setAssociatedObject(self, @selector(mal_lineisHidden), @(mal_lineisHidden), OBJC_ASSOCIATION_ASSIGN);
}

@end
