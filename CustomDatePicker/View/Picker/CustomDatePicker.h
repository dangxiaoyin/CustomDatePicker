//
//  CustomDatePicker.h
//  medical_hp
//
//  Created by dangxy on 16/6/12.
//  Copyright © 2016年 linakge. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CustomDatePickerDelegate <NSObject>

- (void)CustomPickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component year:(NSString *)year month:(NSString *)month day:(NSString *)day;

@end

@interface CustomDatePicker : UIView

@property (nonatomic,strong) UIPickerView *pickerView;

@property (nonatomic, weak) id<CustomDatePickerDelegate> delegate;


@end
