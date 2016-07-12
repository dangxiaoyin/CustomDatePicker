//
//  HistoryHeaderView.m
//  medical_hp
//
//  Created by dangxy on 16/6/8.
//  Copyright © 2016年 linakge. All rights reserved.
//

// rgb颜色转换（16进制->10进制）
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define  MAIN_HEIGHT                  [UIScreen mainScreen].bounds.size.height

#define  MAIN_WIDTH                   [UIScreen mainScreen].bounds.size.width

#define MainColor  UIColorFromRGB(0x4887CA)

#import "HistoryHeaderView.h"
#import "FilterView.h"

@interface HistoryHeaderView ()

@end

@implementation HistoryHeaderView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        [self setup];
    }
    return self;
}

-(void)setup
{
    UIImageView *flag = [[UIImageView alloc] initWithFrame:CGRectMake(10, 12, 3, 16)];
    flag.backgroundColor = UIColorFromRGB(0x68C03C);
    [self addSubview:flag];
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, MAIN_WIDTH-40, 40)];
    title.font = [UIFont systemFontOfSize:13];
    title.textColor = UIColorFromRGB(0x333333);
    title.text = @"历史记录";
    [self addSubview:title];
    
    UIButton *switchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [switchBtn setTitle:@"筛选" forState:UIControlStateNormal];
    [switchBtn setFrame:CGRectMake(MAIN_WIDTH-60, 0, 50, 40)];
    [switchBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    switchBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [switchBtn setBackgroundColor:[UIColor clearColor]];
    [switchBtn addTarget:self action:@selector(filterCondition) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:switchBtn];
}

-(void)filterCondition
{
    FilterView *alert = [[FilterView alloc]init];
    [alert show];
    alert.completeHandle = ^(NSString *input) {
        NSLog(@"input %@",input);
    };
    
    alert.submitBlock = ^(NSInteger isNormal, BOOL isAll, NSString *startTime, NSString *endTime) {
        
        //NSLog(@"isNormal %ld starttime %@ endtime %@",isNormal,startTime,endTime);
        
        // block 传值
        self.submitCompleteHandle(isNormal,isAll,startTime,endTime);
    };
}

@end
