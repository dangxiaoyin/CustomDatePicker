//
//  FilterView.m
//  medical_hp
//
//  Created by dangxy on 16/6/12.
//  Copyright © 2016年 linakge. All rights reserved.
//

#import "FilterView.h"
#import "UIView+SDAutoLayout.h"
#import "CustomDatePicker.h"

#define ALERT_WIDTH    (MAIN_WIDTH-40)
#define TITLE_HEIGHT    46
#define ALERT_HEIGHT   440
#define OK_HEIGHT       43
#define TOP_DISTANCE   100

#define UnChooseImage  [UIImage imageNamed:@"unselect_box"]
#define ChooseImage    [UIImage imageNamed:@"select_box"]

@interface FilterView ()<CustomDatePickerDelegate>

@property (nonatomic, strong) UIView *mAlert, *okOrCancel;
@property (nonatomic, strong) UIButton *closeBtn;
@property (nonatomic, strong) UIButton *OKBtn, *cancelBtn;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *dateCut;
@property (nonatomic, strong) UIImageView *dateFlag;

// 是否勾选 '日期'->'全部'
@property (nonatomic, assign) BOOL isChoose;

// 当前选中 '状态' 第几项
@property (nonatomic, assign) long current_obj;

// start date 开始日期   end date 结束日期
@property (nonatomic, strong) NSString *startDate , *endDate;

@end

@implementation FilterView

- (instancetype)init {
    self = [super init];
    if (self) {
        self.frame = [UIScreen mainScreen].bounds;
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:.3f];
        
        [self drawView];
    }
    return self;
}

- (void)drawView
{
    if (!_mAlert) {
        [self setMainView];
        [self setOkOrCancelView];
    }
}

/**
 *  set main view of alert view
 */
-(void)setMainView
{
    _mAlert = [[UIView alloc]initWithFrame:CGRectMake(20, TOP_DISTANCE, ALERT_WIDTH, ALERT_HEIGHT)];
    _mAlert.layer.cornerRadius = 5.f;
    _mAlert.layer.masksToBounds = YES;
    _mAlert.backgroundColor = [UIColor colorWithWhite:1. alpha:1];
    [self addSubview:_mAlert];
    _mAlert.center = CGPointMake(MAIN_WIDTH/2, MAIN_HEIGHT/2-15);
    
    _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, ALERT_WIDTH, TITLE_HEIGHT)];
    _titleLabel.text = @"筛选条件";
    _titleLabel.textColor = MainColor;
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.font = [UIFont systemFontOfSize:18];
    [_mAlert addSubview:_titleLabel];
    
    _closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_closeBtn setFrame:CGRectMake(ALERT_WIDTH-TITLE_HEIGHT, 0, TITLE_HEIGHT, TITLE_HEIGHT)];
    [_closeBtn setTitle:@"╳" forState:UIControlStateNormal];
    [_closeBtn setTitleColor:MainGray forState:UIControlStateNormal];
    [_closeBtn addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    _closeBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [_mAlert addSubview:_closeBtn];
    
    UIImageView *stateCut = [[UIImageView alloc] init];
    stateCut.backgroundColor = UIColorFromRGB(0xE8E8E8);
    [_mAlert addSubview:stateCut];
    
    stateCut.sd_layout
    .leftSpaceToView(_mAlert,10)
    .rightSpaceToView(_mAlert,10)
    .topSpaceToView(_mAlert,TITLE_HEIGHT+20)
    .heightIs(1);
    
    UILabel *stateMark = [[UILabel alloc] init];
    stateMark.text = @"状态";
    stateMark.textAlignment = NSTextAlignmentCenter;
    stateMark.backgroundColor = [UIColor whiteColor];
    stateMark.font = [UIFont systemFontOfSize:15];
    stateMark.textColor = UIColorFromRGB(0x666666);
    [_mAlert addSubview:stateMark];
    
    stateMark.sd_layout
    .leftSpaceToView(_mAlert,ALERT_WIDTH/2-35)
    .topSpaceToView(_mAlert,TITLE_HEIGHT+10)
    .widthIs(70)
    .heightIs(20);
    
    _dateCut = [[UIImageView alloc] init];
    _dateCut.backgroundColor = UIColorFromRGB(0xE8E8E8);
    [_mAlert addSubview:_dateCut];

    _dateCut.sd_layout
    .leftSpaceToView(_mAlert,10)
    .rightSpaceToView(_mAlert,10)
    .topSpaceToView(_mAlert,TITLE_HEIGHT+100)
    .heightIs(1);
    
    UILabel *dateMark = [[UILabel alloc] init];
    dateMark.text = @"日期";
    dateMark.textAlignment = NSTextAlignmentCenter;
    dateMark.backgroundColor = [UIColor whiteColor];
    dateMark.font = [UIFont systemFontOfSize:15];
    dateMark.textColor = UIColorFromRGB(0x666666);
    [_mAlert addSubview:dateMark];
    
    dateMark.sd_layout
    .leftSpaceToView(_mAlert,ALERT_WIDTH/2-35)
    .topSpaceToView(_mAlert,TITLE_HEIGHT+90)
    .widthIs(70)
    .heightIs(20);

    NSArray *titleArr = @[@"全部",@"正常",@"异常"];
    for (int i = 0; i<3; i++) {
        
        UIImageView *icon = [[UIImageView alloc] init];
        icon.tag = 11+i;
        
        // 初始化对象 默认选中'全部'
        _current_obj = 1;
        icon.image = i == 0 ? ChooseImage:UnChooseImage;
        
        [_mAlert addSubview:icon];
        icon.sd_layout
        .leftSpaceToView(_mAlert,30+(MAIN_WIDTH-60)/3*i)
        .topSpaceToView(stateCut,25)
        .widthIs(26)
        .heightIs(26);
        
        UILabel *title = [[UILabel alloc] init];
        title.text = [titleArr objectAtIndex:i];
        title.textColor = LightGray;
        title.font = [UIFont systemFontOfSize:13];
        [_mAlert addSubview:title];
        
        title.sd_layout
        .leftSpaceToView(icon,7)
        .topEqualToView(icon)
        .widthIs(40)
        .heightIs(26);
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setBackgroundColor:[UIColor clearColor]];
        btn.tag = i+1;
        [_mAlert addSubview:btn];
        [btn addTarget:self action:@selector(stateChooseBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        btn.sd_layout
        .leftEqualToView(icon)
        .rightEqualToView(title)
        .topEqualToView(title)
        .heightIs(26);
    }
    
    _dateFlag = [[UIImageView alloc] init];
    _dateFlag.tag = 14;
    
    // 默认选中 '全部'
    _isChoose = YES;
    _dateFlag.image = ChooseImage;
    
    [_mAlert addSubview:_dateFlag];
    _dateFlag.sd_layout
    .leftSpaceToView(_mAlert,30)
    .topSpaceToView(_dateCut,25)
    .widthIs(26)
    .heightIs(26);
    
    UILabel *title = [[UILabel alloc] init];
    title.text = @"全部";
    title.textColor = LightGray;
    title.font = [UIFont systemFontOfSize:13];
    [_mAlert addSubview:title];
    
    title.sd_layout
    .leftSpaceToView(_dateFlag,7)
    .topEqualToView(_dateFlag)
    .widthIs(40)
    .heightIs(26);

    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.tag = 4;
    [btn setBackgroundColor:[UIColor clearColor]];
    [_mAlert addSubview:btn];
    [btn addTarget:self action:@selector(dateChooseBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    btn.sd_layout
    .leftEqualToView(_dateFlag)
    .rightEqualToView(title)
    .topEqualToView(title)
    .heightIs(26);

    // custom picker view
    [self initDatePicker];
    
    // 系统自带 不可定制
    //[self setDatePickerView];
}

-(void)initDatePicker
{
    
    // 当前时间 选择器默认显示时间
    NSDate* date = [NSDate date];
    NSDateFormatter *fm =[[NSDateFormatter alloc] init];
    fm.dateFormat = @"yyyy年MM月dd日";
    
    // 属性赋值 初始化
    _startDate = [fm stringFromDate:date];
    _endDate = [fm stringFromDate:date];

    
    CustomDatePicker *startDate = [[CustomDatePicker alloc] init];
    startDate.pickerView.tag = 1;
    startDate.delegate = self;
    [_mAlert addSubview:startDate];
    
    startDate.sd_layout
    .leftSpaceToView(_mAlert,0)
    .topSpaceToView(_dateCut,50)
    .widthIs(ALERT_WIDTH)
    .heightIs(100);
    
    UILabel *endMark = [[UILabel alloc] init];
    endMark.text = @"至";
    endMark.textAlignment = NSTextAlignmentCenter;
    endMark.font = [UIFont systemFontOfSize:18];
    endMark.textColor = MainColor;
    [_mAlert addSubview:endMark];
    
    endMark.sd_layout
    .leftSpaceToView(_mAlert,0)
    .topSpaceToView(startDate,0)
    .widthIs(ALERT_WIDTH)
    .heightIs(30);

    CustomDatePicker *endDate = [[CustomDatePicker alloc] init];
    endDate.pickerView.tag = 2;
    endDate.delegate = self;
    [_mAlert addSubview:endDate];
    
    endDate.sd_layout
    .leftSpaceToView(_mAlert,0)
    .topSpaceToView(startDate,30)
    .widthIs(ALERT_WIDTH)
    .heightIs(100);

}

// custom picker view delegate

- (void)CustomPickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component year:(NSString *)year month:(NSString *)month day:(NSString *)day
{

    _isChoose = NO;
    _dateFlag.image = UnChooseImage;

    if (pickerView.tag == 1) {
        _startDate = [NSString stringWithFormat:@"%@%@%@",year,month,day];
    }
    if (pickerView.tag == 2) {
        _endDate = [NSString stringWithFormat:@"%@%@%@",year,month,day];
    }
}

/**
 *  状态 [全部 正常 异常]
 */
-(void)stateChooseBtnClick:(UIButton *)btn
{
    UIImageView *front = (UIImageView *)[_mAlert viewWithTag:_current_obj+10];
    front.image = UnChooseImage;
    UIImageView *icon = (UIImageView *)[_mAlert viewWithTag:btn.tag+10];
    icon.image = ChooseImage;
    
    _current_obj = btn.tag;
}

/**
 *  日期 [全部 非全部]
 */
-(void)dateChooseBtnClick:(UIButton *)btn
{
    _isChoose = !_isChoose;
    _dateFlag.image = _isChoose ? ChooseImage:UnChooseImage;
}

-(void)setDatePickerView
{
    // 当前时间 选择器默认显示时间
    NSDate* date = [NSDate date];
    NSDateFormatter *fm =[[NSDateFormatter alloc] init];
    fm.dateFormat = @"yyyy年MM月dd日";
    
    // 属性赋值 初始化
    _startDate = [fm stringFromDate:date];
    _endDate = [fm stringFromDate:date];
    
    UIDatePicker *startDatePicker = [[UIDatePicker alloc] init];
    startDatePicker.tag = 1;
    startDatePicker.datePickerMode = UIDatePickerModeDate;
    [startDatePicker addTarget:self action:@selector(disPlayDate:) forControlEvents:UIControlEventValueChanged];
    [_mAlert addSubview:startDatePicker];
    
    for (UIView *subView1 in startDatePicker.subviews)
    {
        if ([subView1 isKindOfClass:[UIPickerView class]])//取出UIPickerView
        {
            for(UIView *subView2 in subView1.subviews)
            {
                if (subView2.frame.size.height < 1)//取出分割线view
                {
                    subView2.hidden = YES;//隐藏分割线
                }
            }
        }
    }
    
    startDatePicker.sd_layout
    .leftSpaceToView(_mAlert,0)
    .topSpaceToView(_dateCut,55)
    .widthIs(ALERT_WIDTH)
    .heightIs(100);
    
    
    UILabel *endMark = [[UILabel alloc] init];
    endMark.text = @"至";
    endMark.textAlignment = NSTextAlignmentCenter;
    endMark.font = [UIFont systemFontOfSize:18];
    endMark.textColor = MainColor;
    [_mAlert addSubview:endMark];
    
    endMark.sd_layout
    .leftSpaceToView(_mAlert,0)
    .topSpaceToView(startDatePicker,0)
    .widthIs(ALERT_WIDTH)
    .heightIs(30);

    
    UIDatePicker *endDatePicker = [[UIDatePicker alloc] init];
    endDatePicker.tag = 2;
    endDatePicker.datePickerMode = UIDatePickerModeDate;
    [endDatePicker addTarget:self action:@selector(disPlayDate:) forControlEvents:UIControlEventValueChanged];
    [_mAlert addSubview:endDatePicker];
    
    endDatePicker.sd_layout
    .leftSpaceToView(_mAlert,0)
    .topSpaceToView(startDatePicker,30)
    .widthIs(ALERT_WIDTH)
    .heightIs(100);

    for (UIView *subView1 in endDatePicker.subviews)
    {
        if ([subView1 isKindOfClass:[UIPickerView class]])//取出UIPickerView
        {
            for(UIView *subView2 in subView1.subviews)
            {
                if (subView2.frame.size.height < 1)//取出分割线view
                {
                    subView2.hidden = YES;//隐藏分割线
                }
            }
        }
    }
}

-(void)disPlayDate:(UIDatePicker *)datePicker
{
    _isChoose = NO;
    _dateFlag.image = UnChooseImage;

    
    NSDate* date = datePicker.date;
    NSDateFormatter *fm =[[NSDateFormatter alloc] init];
    fm.dateFormat = @"yyyy年MM月dd日";
    
    if (datePicker.tag == 1) {
        
        _startDate = [fm stringFromDate:date];
    }
    else if (datePicker.tag == 2) {
        
        _endDate = [fm stringFromDate:date];
    }
}


/**
 *  set ok or cancel view of alert view
 */
-(void)setOkOrCancelView
{
    _okOrCancel = [[UIView alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(_mAlert.frame)+10, ALERT_WIDTH, OK_HEIGHT)];
    _okOrCancel.layer.cornerRadius = 5.f;
    _okOrCancel.layer.masksToBounds = YES;
    _okOrCancel.backgroundColor = [UIColor colorWithWhite:1. alpha:.95];
    [self addSubview:_okOrCancel];
    
    _OKBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_OKBtn setFrame:CGRectMake(0, 0, ALERT_WIDTH/2, OK_HEIGHT)];
    [_OKBtn setTitle:@"确定" forState:UIControlStateNormal];
    [_OKBtn setTitleColor:MainGray forState:UIControlStateNormal];
    [_OKBtn addTarget:self action:@selector(submit) forControlEvents:UIControlEventTouchUpInside];
    _OKBtn.titleLabel.font = [UIFont systemFontOfSize:17];
    [_okOrCancel addSubview:_OKBtn];
    
    UIImageView *cut = [[UIImageView alloc] initWithFrame:CGRectMake(ALERT_WIDTH/2-0.5, 10, 1, OK_HEIGHT-20)];
    cut.backgroundColor = UIColorFromRGB(0xD7D7D7);
    [_okOrCancel addSubview:cut];
    
    _cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_cancelBtn setFrame:CGRectMake(ALERT_WIDTH/2, 0, ALERT_WIDTH/2, OK_HEIGHT)];
    [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [_cancelBtn setTitleColor:MainGray forState:UIControlStateNormal];
    [_cancelBtn addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    _cancelBtn.titleLabel.font = [UIFont systemFontOfSize:17];
    [_okOrCancel addSubview:_cancelBtn];
}

-(void)submit
{
    int m = [self compareDate:_startDate withDate:_endDate];
    if (m==-1 && _isChoose == NO) {
        
//        UIWindow *win = [UIApplication sharedApplication].keyWindow;
//        [PubllicMaskViewHelper showTipViewWith:@"开始日期不能大于结束日期!" inSuperView:win withDuration:1];
        return;
    }
    
    [self dismiss];
    self.submitBlock(_current_obj-1,_isChoose,_startDate,_endDate);
}

/**
 *  比较开始时间/结束时间
 */
-(int)compareDate:(NSString*)starttime withDate:(NSString*)endtime
{
    int ret;
    
    // 日期类型转化
    NSDateFormatter *fm = [[NSDateFormatter alloc] init];
    [fm setDateFormat:@"yyyy年MM月dd日"];
    NSDate *startdt = [fm dateFromString:starttime];
    NSDate *enddt = [fm dateFromString:endtime];
    
    [fm setDateFormat:@"yyyy-MM-dd"];
    NSString *starttm = [fm stringFromDate:startdt];
    NSString *endtm = [fm stringFromDate:enddt];

    NSDate *dt1 = [fm dateFromString:starttm];
    NSDate *dt2 = [fm dateFromString:endtm];
    
    NSComparisonResult result = [dt1 compare:dt2];
    
    switch (result)
    {
        // endtime > starttime
        case NSOrderedAscending: ret=1; break;
            
        // endtime < starttime
        case NSOrderedDescending: ret=-1; break;
            
        // endtime = starttime
        case NSOrderedSame: ret=0; break;
            
        default: NSLog(@"erorr dates %@, %@", dt2, dt1); break;
    }
    return ret;
}

- (void)show {
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    [keyWindow addSubview:self];
    
    _mAlert.transform = CGAffineTransformMakeScale(1.21f, 1.21f);
    _mAlert.alpha = 0;
    
    _okOrCancel.transform = CGAffineTransformMakeScale(1.21f, 1.21f);
    _okOrCancel.alpha = 0;

    
    [UIView animateWithDuration:.7f delay:0.f usingSpringWithDamping:.7f initialSpringVelocity:1 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        _mAlert.transform = CGAffineTransformMakeScale(1.0f, 1.0f);
        _mAlert.alpha = 1.0;
        _okOrCancel.transform = CGAffineTransformMakeScale(1.0f, 1.0f);
        _okOrCancel.alpha = 1.0;

    } completion:nil];
}

- (void)dismiss {
    [UIView animateWithDuration:0.3f animations:^{
        _mAlert.transform = CGAffineTransformMakeScale(1.21f, 1.21f);
        _mAlert.alpha = 0;
        _okOrCancel.transform = CGAffineTransformMakeScale(1.21f, 1.21f);
        _okOrCancel.alpha = 0;
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}




@end
