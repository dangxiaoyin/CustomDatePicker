//
//  CustomDatePicker.m
//  medical_hp
//
//  Created by dangxy on 16/6/12.
//  Copyright © 2016年 linakge. All rights reserved.
//

// rgb颜色转换（16进制->10进制）
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define  MAIN_HEIGHT                  [UIScreen mainScreen].bounds.size.height

#define  MAIN_WIDTH                   [UIScreen mainScreen].bounds.size.width

#define MainColor  UIColorFromRGB(0x4887CA)

#import "CustomDatePicker.h"
#import "UIPickerView+malPicker.h"

@interface CustomDatePicker ()<UIPickerViewDataSource,UIPickerViewDelegate>

@property (nonatomic,strong) NSArray *yearArr , *monthArr , *dayArr;

@property (nonatomic,strong) NSString *yearNow , *monthNow , *dayNow;

// 当前 '年' '月' '日' 数组中所占的索引值
@property (nonatomic,assign) NSInteger rowLeft , rowMiddle , rowRight;

// the year and month of displaying on view now
@property (nonatomic,assign) NSInteger chosenYear , chosenMonth , chosenDay;

@end

@implementation CustomDatePicker

-(instancetype)init
{
    self = [super init];
    
    if (self) {
        [self setup];
    }
    return self;
}

-(void)setup
{
    [self timeNow];
    
    [self timeArray];
    
    _pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, MAIN_WIDTH-40, 100)];
    _pickerView.dataSource = self;
    _pickerView.delegate = self;
    [self addSubview:_pickerView];
    
    [self defaultDisplay];
}

/**
 *  年 月 日 数组
 */
-(void)timeArray
{
    NSInteger yearN = [_yearNow integerValue];
    
    _yearArr = [[NSMutableArray alloc] initWithObjects:
                [self stringCombine:[NSString stringWithFormat:@"%ld",yearN-4] string:@"年"],
                [self stringCombine:[NSString stringWithFormat:@"%ld",yearN-3] string:@"年"],
                [self stringCombine:[NSString stringWithFormat:@"%ld",yearN-2] string:@"年"],
                [self stringCombine:[NSString stringWithFormat:@"%ld",yearN-1] string:@"年"],
                [self stringCombine:[NSString stringWithFormat:@"%ld",yearN] string:@"年"],
                nil];
    
    _monthArr = @[@"01月",@"02月",@"03月",@"04月",@"05月",@"06月",@"07月",@"08月",@"09月",@"10月",@"11月",@"12月",];
    
    _dayArr = @[@"01日",@"02日",@"03日",@"04日",@"05日",@"06日",@"07日",@"08日",@"09日",@"10日",@"11日",@"12日",@"13日",@"14日",@"15日",@"16日",@"17日",@"18日",@"19日",@"20日",@"21日",@"22日",@"23日",@"24日",@"25日",@"26日",@"27日",@"28日",@"29日",@"30日",@"31日"];
}

-(void)timeNow
{
    // 当前时间 选择器默认显示时间
    NSDate* date = [NSDate date];
    NSDateFormatter *fm =[[NSDateFormatter alloc] init];
    fm.dateFormat = @"yyyy";
    self.yearNow = [fm stringFromDate:date];
    self.chosenYear = [_yearNow integerValue];
    
    fm.dateFormat = @"MM";
    self.monthNow = [fm stringFromDate:date];
    self.chosenMonth = [_monthNow integerValue];
    
    fm.dateFormat = @"dd";
    self.dayNow = [fm stringFromDate:date];
    self.chosenDay = [_dayNow integerValue];
}

/**
 *  默认显示当前时间
 */
-(void)defaultDisplay
{
    NSUInteger rowLeft = [_yearArr indexOfObject:[self stringCombine:_yearNow string:@"年"]];
    NSUInteger rowMiddle = [_monthArr indexOfObject:[self stringCombine:_monthNow string:@"月"]];
    NSUInteger rowRight = [_dayArr indexOfObject:[self stringCombine:_dayNow string:@"日"]];
    
    _rowLeft = rowLeft;
    _rowMiddle = rowMiddle;
    _rowRight = rowRight;
    
    [_pickerView selectRow:rowLeft inComponent:0 animated:YES];
    [_pickerView selectRow:rowMiddle inComponent:1 animated:YES];
    [_pickerView selectRow:rowRight inComponent:2 animated:YES];

}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component == 0)
    {
        return _yearArr.count;
    }
    
    else if (component == 1)
    {
        return _monthArr.count;
    }
    else
    {
        if ((self.chosenMonth == 1) || (self.chosenMonth == 3) || (self.chosenMonth == 5) ||(self.chosenMonth == 7)||(self.chosenMonth == 8)||(self.chosenMonth == 10)||(self.chosenMonth == 12))
        {
            return 31;
        }
        if ((self.chosenMonth == 4)||(self.chosenMonth == 6)||(self.chosenMonth == 9)||(self.chosenMonth == 11)) {
            return 30;
        }
        if ((self.chosenYear % 100 != 0)&(self.chosenYear % 4 == 0)) {
            return 29;
        }
        if ((self.chosenYear % 400 == 0)) {
            return 29;
        }
        return 28;
    }
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (component == 0)
    {
        return  [_yearArr objectAtIndex:row];
    }
    
    else if(component == 1)
    {
        return [_monthArr objectAtIndex:row];
    }
    
    else
    {
        return [_dayArr objectAtIndex:row];
    }
    return nil;
}


- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel* pickerLabel = (UILabel*)view;
    if (!pickerLabel){
        pickerLabel = [[UILabel alloc] init];
        //pickerLabel.minimumFontSize = 8.;
        pickerLabel.adjustsFontSizeToFitWidth = YES;
        pickerLabel.textAlignment = NSTextAlignmentCenter;
        pickerLabel.textColor = UIColorFromRGB(0x666666);
        [pickerLabel setBackgroundColor:[UIColor clearColor]];
        [pickerLabel setFont:[UIFont systemFontOfSize:17]];
    }
    // Fill the label text here
    pickerLabel.text=[self pickerView:pickerView titleForRow:row forComponent:component];
    
    [pickerView clearSpearatorLine];
    return pickerLabel;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    NSString *year , *month , *day;
    
    if (component == 0) {
        
        _rowLeft = row;
        [self commonYearOrLeapYear];
    }
    if (component == 1) {
        
        _rowMiddle = row;
        [self numberOfDaysEachMonth];
    }
    
    if (component == 2) {
        _rowRight = row;
    }
    
    year = _yearArr[_rowLeft];
    month = _monthArr[_rowMiddle];
    day = _dayArr[_rowRight];
    
    NSArray *yearArr = [year componentsSeparatedByString:@"年"];
    NSArray *monthArr = [month componentsSeparatedByString:@"月"];
    NSArray *dayArr = [day componentsSeparatedByString:@"日"];
    
    self.chosenYear = [yearArr[0] integerValue];
    self.chosenMonth = [monthArr[0] integerValue];
    self.chosenDay = [dayArr[0] integerValue];
    
    // 刷新
    [pickerView reloadComponent:2];
    
    //NSLog(@"current date pick %@%@%@",year,month,day);
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(CustomPickerView:didSelectRow:inComponent:year:month:day:)]) {
        [self.delegate CustomPickerView:pickerView didSelectRow:row inComponent:component year:year month:month day:day];
    }
}

/**
 *  判断平年还是闰年
 */
-(void)commonYearOrLeapYear
{
    NSString *year = _yearArr[_rowLeft];
    NSArray *strArr = [year componentsSeparatedByString:@"年"];
    
    self.chosenYear = [strArr[0] integerValue];
    self.chosenMonth = _rowMiddle+1;
    
    if ((self.chosenMonth == 1) || (self.chosenMonth == 3) || (self.chosenMonth == 5) ||(self.chosenMonth == 7)||(self.chosenMonth == 8)||(self.chosenMonth == 10)||(self.chosenMonth == 12))
    {
        
    }
    else if ((self.chosenMonth == 4)||(self.chosenMonth == 6)||(self.chosenMonth == 9)||(self.chosenMonth == 11)) {
        
        if (_rowRight > 29) {
            _rowRight =  29;
        }
    }
    else if ((self.chosenYear % 100 != 0)&(self.chosenYear % 4 == 0)) {
        
        if (_rowRight > 28) {
            _rowRight =  28;
        }
    }
    else if ((self.chosenYear % 400 == 0)) {
        
        if (_rowRight > 28) {
            _rowRight =  28;
        }
    }
    
    else if (_rowRight > 27) {
        _rowRight =  27;
    }
}


/**
 *  判断每个月的天数
 */
-(void)numberOfDaysEachMonth
{
    NSString *year = _yearArr[_rowLeft];
    NSArray *strArr = [year componentsSeparatedByString:@"年"];
    
    self.chosenYear = [strArr[0] integerValue];
    self.chosenMonth = _rowMiddle+1;
    
    if ((self.chosenMonth == 1) || (self.chosenMonth == 3) || (self.chosenMonth == 5) ||(self.chosenMonth == 7)||(self.chosenMonth == 8)||(self.chosenMonth == 10)||(self.chosenMonth == 12))
    {
        
    }
    else if ((self.chosenMonth == 4)||(self.chosenMonth == 6)||(self.chosenMonth == 9)||(self.chosenMonth == 11)) {
        
        if (_rowRight > 29) {
            _rowRight =  29;
        }
    }
    else if ((self.chosenYear % 100 != 0)&(self.chosenYear % 4 == 0)) {
        
        if (_rowRight > 28) {
            _rowRight =  28;
        }
    }
    else if ((self.chosenYear % 400 == 0)) {
        
        if (_rowRight > 28) {
            _rowRight =  28;
        }
    }
    
    else if (_rowRight > 27) {
        _rowRight =  27;
    }
}

//字符串拼接
- (NSString *)stringCombine:(NSString *)str string:(NSString *)string
{
    NSString *stringCom = [NSString stringWithFormat:@"%@%@",str,string];
    return stringCom;
}


@end
