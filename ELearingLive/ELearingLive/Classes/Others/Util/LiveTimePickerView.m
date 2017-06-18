//
//  LiveTimePickerView.h
//
//
//  Created by leo on 16/6/23.
//  Copyright © 2016年 AlexiChen. All rights reserved.
//
#import "LiveTimePickerView.h"
#import "LiveCastTimeTool.h"

#define HOURARRAY @[@"0点", @"1点", @"2点", @"3点", @"4点", @"5点", @"6点", @"7点", @"8点", @"9点", @"10点", @"11点", @"12点", @"13点", @"14点", @"15点", @"16点", @"17点", @"18点", @"19点", @"20点", @"21点", @"22点", @"23点"]
#define ALLHOURARRAY @[@"0点", @"1点", @"2点", @"3点", @"4点", @"5点", @"6点", @"7点", @"8点", @"9点", @"10点", @"11点", @"12点", @"13点", @"14点", @"15点", @"16点", @"17点", @"18点", @"19点", @"20点", @"21点", @"22点", @"23点"]

#define MINUTEARRAY @[@"0分", @"10分", @"20分", @"30分", @"40分", @"50分"]

typedef void(^CompleteBolck) (NSDictionary *);

@interface LiveTimePickerView (){
    UILabel * topLine;
    UIPickerView *myPickerView;
    
}

@property (nonatomic, strong) NSArray *dayArray;
@property (nonatomic, strong) NSArray *showDayArray;
@property (nonatomic, strong) NSArray *hourArray;
@property (nonatomic, strong) NSArray *minuteArray;

@property (nonatomic, copy) CompleteBolck completeBlock;

@end

@implementation LiveTimePickerView

-(id)initWithFrame:(CGRect)frame completeBlock:(void (^)(NSDictionary *infoDic))completeBlock{

    self.completeBlock = completeBlock;
    return [self initWithFrame:frame];
    
}


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor =[UIColor groupTableViewBackgroundColor];
    }
    return self;
}
- (id)init
{
    self = [super init];
    if (self) {
        self.backgroundColor =[UIColor groupTableViewBackgroundColor];
    }
    return self;
}
//进行初始化
- (void)drawRect:(CGRect)rect
{
    _dayArray = [LiveCastTimeTool daysFromNowToSevenDay];
    _showDayArray = [LiveCastTimeTool daysStrFromNowToSevenDay];
    _hourArray = [self validHourArray];
    _minuteArray = [self validMinuteArray];
    if (!topLine) {
        topLine = [[UILabel alloc] initWithFrame:CGRectMake(0,0, Main_Screen_Width, 1)];
        topLine.backgroundColor = CELL_BORDER_COLOR;
        [self addSubview:topLine];
    }
    if (!myPickerView) {
        myPickerView = [[UIPickerView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 230)];
        myPickerView.showsSelectionIndicator = YES;
        myPickerView.backgroundColor = [UIColor clearColor];
        myPickerView.delegate = self;
        myPickerView.dataSource = self;
        [self addSubview:myPickerView];
    }
    [self customBtn];
}

-(void)updateReLoadDate{
    _dayArray = [LiveCastTimeTool daysFromNowToSevenDay];
    _showDayArray = [LiveCastTimeTool daysStrFromNowToSevenDay];
    _hourArray = [self validHourArray];
    _minuteArray = [self validMinuteArray];
}

- (void)customBtn
{
    UIButton * confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    confirmBtn.frame = CGRectMake(Main_Screen_Width - 60, 10, 50, 35);
    [confirmBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [confirmBtn setTitle:@"确定" forState:UIControlStateNormal];
    [confirmBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    confirmBtn.tag = 100;
    [self addSubview:confirmBtn];
    
    UIButton * cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelBtn.frame = CGRectMake(10,  10, 50, 35);
    cancelBtn.tag = 101;
    [cancelBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self addSubview:cancelBtn];
}

-(void)btnClick:(UIButton *)btn{
    if (btn.tag == 100) {
        NSMutableDictionary *infoDic = [NSMutableDictionary dictionary];
        NSInteger firstIndex = [myPickerView selectedRowInComponent:0];
        NSInteger secodnIndex = [myPickerView selectedRowInComponent:1];
        NSInteger thirdIndex = [myPickerView selectedRowInComponent:2];
        if (_showDayArray.count >firstIndex&& _dayArray.count >firstIndex && _hourArray.count>secodnIndex &&_minuteArray.count >thirdIndex) {
            infoDic[@"date_value"] = [NSString stringWithFormat:@"%@ %@:%@",_dayArray[firstIndex],[self formatOriArray:_hourArray][secodnIndex],[self formatOriArray:_minuteArray][thirdIndex]];
            
            infoDic[@"date_str"] = [NSString stringWithFormat:@"%@ %@ %@",_showDayArray[firstIndex],_hourArray[secodnIndex],_minuteArray[thirdIndex]];
            
            self.completeBlock(infoDic);
        }else{
            self.completeBlock(nil);
        }
      
    }else{
        self.completeBlock(nil);
    }
  
}


-(NSArray *)formatOriArray:(NSArray *)oriArray{
    NSMutableArray *newArray = [NSMutableArray array];
    for (NSString *hourStr in oriArray) {
        NSString *tmpStr = [self removeLastChareacter:hourStr];
        [newArray addObject: [self append0IfNeed:tmpStr]];
    }
    return newArray;
}

-(NSString *)removeLastChareacter:(NSString *)oriString{
    return [oriString substringToIndex:oriString.length -1];
}

-(NSString *)append0IfNeed:(NSString *)oriString{
    if(oriString.length <2) return [NSString stringWithFormat:@"0%@", oriString];
    return oriString;
}


#pragma mark - pickerview data and delegate

-(NSArray *)validHourArray{
    NSInteger startIndex = [LiveCastTimeTool currentDateHour];
    if ([LiveCastTimeTool currentDateMinute] >= 50) startIndex++;
    NSArray *tempHourArray = [ALLHOURARRAY subarrayWithRange:NSMakeRange(startIndex, ALLHOURARRAY.count - startIndex)];
    NSMutableArray *arrayReturn = [NSMutableArray array];
    for (NSString *hourStr in tempHourArray) {
        if ([HOURARRAY containsObject:hourStr]) {
            [arrayReturn addObject:hourStr];
        }
    }
    return arrayReturn;
}

-(NSArray *)validMinuteArray{
    
    
    NSInteger startIndexH = [LiveCastTimeTool currentDateHour];
    
    NSArray *tempHourArray = [ALLHOURARRAY subarrayWithRange:NSMakeRange(startIndexH, ALLHOURARRAY.count - startIndexH)];
    BOOL canAddMinute = NO;
    for (NSString *hourStr in tempHourArray) {
        if ([HOURARRAY containsObject:hourStr]) {
            canAddMinute = YES;
        }
    }
    if (!canAddMinute) {
        return [NSArray array];
    }
    
    NSInteger startIndex = [LiveCastTimeTool currentDateMinute] / 10 + 1;
    
    if ([LiveCastTimeTool currentDateMinute] >= 50) startIndex = 0;
    
    return [MINUTEARRAY subarrayWithRange:NSMakeRange(startIndex, MINUTEARRAY.count - startIndex)];
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    switch (component) {
        case 0:
            return self.showDayArray.count;
        case 1:
            return self.hourArray.count;
        case 2:
            return self.minuteArray.count;
        default:
            return 0;
    }
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    NSInteger firstComponentSelectedRow = [myPickerView selectedRowInComponent:0];
    if (firstComponentSelectedRow == 0) {
        _hourArray = [self validHourArray];
        _minuteArray = [self validMinuteArray];
        NSInteger secondComponentSelectedRow = [myPickerView selectedRowInComponent:1];
        if (secondComponentSelectedRow == 0 || component ==0) {
            _minuteArray = [self validMinuteArray];
        }else{
            _minuteArray = MINUTEARRAY;
        }
    }else{
        _hourArray = HOURARRAY;
        _minuteArray = MINUTEARRAY;
    }
    [myPickerView reloadAllComponents];
    
    //当第一列滑到第一个位置时，第二，三列滚回到0位置
    if(component == 0){
        [myPickerView selectRow:0 inComponent:1 animated:YES];
        [myPickerView selectRow:0 inComponent:2 animated:YES];
    }
}

-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    UILabel *label;
    if (view) {
        label = (UILabel *)view;
    }else{
        label = [[UILabel alloc] init];
    }
    label.textAlignment = NSTextAlignmentCenter;
    switch (component) {
        case 0:
            label.text = self.showDayArray[row];
            break;
        case 1:
            label.text = self.hourArray[row];
       
            break;
        case 2:
            label.text = self.minuteArray[row];
            break;
        default:
            break;
    }
    return label;
}


-(CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component{
    
    CGFloat width = Main_Screen_Width/5.0;
    if (component ==0) {
        return width *2.5;
    }
    return width *1.25;
}


-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return 44;
}


@end
