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
    
//    [self setBG];
    
//    [self filterCondition];
    
    [self stringTest];
}

-(void)setBG
{
    UIImageView *IMG = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, MAIN_WIDTH, MAIN_HEIGHT)];
    [IMG setImage:[UIImage imageNamed:@"IMG"]];
    [self.view addSubview:IMG];
    
}

-(void)stringTest
{
    UILabel *content = [[UILabel alloc] initWithFrame:CGRectMake(20, 100, MAIN_WIDTH-40, 90)];
    content.numberOfLines = 0;
    content.text = @"改变字符串中指定字符的颜色,改变字符串中指定字符的颜色,改变字符串中指定字符的颜色,改变字符串中指定字符的颜色,改变字符串中指定字符的颜色!";
    [self.view addSubview:content];
    
    NSRange range = [content.text rangeOfString:@"字符串"];
    [self setTextColor:content FontNumber:[UIFont systemFontOfSize:13] AndRange:range AndColor:[UIColor orangeColor]];
    
//    for (int i = 0; i<[content.text length]-2; i++) {
//        
//        // 截取字符串中的每一个字符
//        NSString *character = [content.text  substringWithRange:NSMakeRange(i, 3)];
//        NSLog(@"character is %@",character);
//        
//        if ([character isEqualToString:@"字符串"]) {
//            NSRange range = NSMakeRange(i, 3);
//            //将字符串替换
//            content.text = [content.text stringByReplacingCharactersInRange:range withString:@"YYY"];
//        }
//    }
//    NSLog(@"%@",content.text );
}


//设置不同字体颜色
-(void)setTextColor:(UILabel *)label FontNumber:(id)font AndRange:(NSRange)range AndColor:(UIColor *)vaColor
{
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:label.text];
    //设置字号
    [str addAttribute:NSFontAttributeName value:font range:range];
    //设置文字颜色
    [str addAttribute:NSForegroundColorAttributeName value:vaColor range:range];
    
    label.attributedText = str;
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
