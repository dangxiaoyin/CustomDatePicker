//
//  HistoryHeaderView.h
//  medical_hp
//
//  Created by dangxy on 16/6/8.
//  Copyright © 2016年 linakge. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HistoryHeaderView : UIView

// isNormal [0 '全部'  1 '正常'  2 '异常']
@property (nonatomic,copy) void (^submitCompleteHandle)(NSInteger isNormal, BOOL isAll, NSString *startTime, NSString *endTime);

@end
