//
//  ViewController.m
//  CustomDatePicker
//
//  Created by dangxy on 16/7/12.
//  Copyright © 2016年 xproinfo.com. All rights reserved.
//

#import "ViewController.h"
//#import "HistoryHeaderView.h"
#import "FilterView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setBG];
    
    [self filterCondition];
}

-(void)setBG
{
    UIImageView *IMG = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, MAIN_WIDTH, MAIN_HEIGHT)];
    [IMG setImage:[UIImage imageNamed:@"IMG"]];
    [self.view addSubview:IMG];
}

-(void)filterCondition
{
    
    FilterView *alert = [[FilterView alloc]init];
    
    [self.view addSubview:alert];
//    [alert show];
    alert.completeHandle = ^(NSString *input) {
        NSLog(@"input %@",input);
    };
    
    alert.submitBlock = ^(NSInteger isNormal, BOOL isAll, NSString *startTime, NSString *endTime) {
        
        //NSLog(@"isNormal %ld starttime %@ endtime %@",isNormal,startTime,endTime);
        
        // block 传值
//        self.submitCompleteHandle(isNormal,isAll,startTime,endTime);
    };

//    HistoryHeaderView *picker = [[HistoryHeaderView alloc] initWithFrame:CGRectMake(0, 200, MAIN_WIDTH, 40)];
//    
//    picker.submitCompleteHandle = ^(NSInteger isNormal, BOOL isAll, NSString *startTime, NSString *endTime)
//    {
//        
//        NSString *isNor = [NSString stringWithFormat:@"%ld",isNormal];
//        
//        // 日期类型转化
//        NSDateFormatter *fm = [[NSDateFormatter alloc] init];
//        [fm setDateFormat:@"yyyy年MM月dd日"];
//        NSDate *startdt = [fm dateFromString:startTime];
//        NSDate *enddt = [fm dateFromString:endTime];
//        
//        [fm setDateFormat:@"yyyy-MM-dd"];
//        NSString *starttm = [fm stringFromDate:startdt];
//        NSString *endtm = [fm stringFromDate:enddt];
//        
//        
//        if (isAll == YES) {
//            starttm = @"";
//            endtm = @"";
//        }
//        
//        NSLog(@"isNormal %@ isAll %d starttime %@ endtime %@",isNor,isAll,starttm,endtm);
//        };
//    
//    [self.view addSubview:picker];
}


@end
