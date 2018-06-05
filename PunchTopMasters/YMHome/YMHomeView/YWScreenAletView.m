//
//  YWScreenAletView.m
//  PunchTopMasters
//
//  Created by 蔡路飞 on 2018/3/28.
//  Copyright © 2018年 蔡路飞. All rights reserved.
//

#import "YWScreenAletView.h"
@interface YWScreenAletView()<UIPickerViewDelegate,UIPickerViewDataSource>

@property (weak, nonatomic) IBOutlet UIButton *sureBt;

@property (weak, nonatomic) IBOutlet UIPickerView *pickView;
@property(nonatomic,strong)NSMutableDictionary * selectDict;
@end
@implementation YWScreenAletView
-(void)awakeFromNib{
    [super awakeFromNib];
    self.pickView.delegate = self;
    self.pickView.dataSource = self;
    
    
    //    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    //     [ self.pickView selectRow:3 inComponent:0 animated:NO];
    //    });
    
    [self.sureBt addTarget:self action:@selector(sureBtClick) forControlEvents:UIControlEventTouchUpInside];
}
-(void)sureBtClick{
    [GKCover hideCover];
    self.sureClickScreenAletView(self.selectDict);
}
-(void)setArray:(NSMutableArray *)array{
    _array = array;
    self.selectDict = [array firstObject];
    [self.pickView reloadAllComponents];
      [self.pickView selectRow:0 inComponent:0 animated:YES];
  
}
+(instancetype)loadNameYWScreenAletViewXib {
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] lastObject];
}
//指定pickerview有几个表盘
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;//第一个展示字母、第二个展示数字
}

//指定每个表盘上有几行数据
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    
    return self.array.count;
}
//指定每行如何展示数据（此处和tableview类似）
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSMutableDictionary * dict= self.array[row];
    
    return dict[@"name"];
}
//选中某行后回调的方法，获得选中结果
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    self.selectDict = self.array[row];
}
-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return 50;
}
#pragma mark 给pickerview设置字体大小和颜色等
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    
    //设置分割线的颜色
    for(UIView *singleLine in pickerView.subviews)
    {
        if (singleLine.frame.size.height < 1)
        {
            singleLine.clf_height = 0.4;
            singleLine.backgroundColor = grayBgColor;
        }
    }
    //可以通过自定义label达到自定义pickerview展示数据的方式
    UILabel* pickerLabel = (UILabel*)view;
    
    if (!pickerLabel)
    {
        pickerLabel = [[UILabel alloc] init];
        
        pickerLabel.adjustsFontSizeToFitWidth = YES;
        pickerLabel.textAlignment = NSTextAlignmentCenter;
//        [pickerLabel setBackgroundColor:publishTextColor];
        [pickerLabel setFont:[UIFont fontWithName:@"PingFangSC-Light"size:15.f]];
    }
    
    pickerLabel.text=[self pickerView:pickerView titleForRow:row forComponent:component];//调用上一个委托方法，获得要展示的title
    
    return pickerLabel;
}
////2.1 返回一个富文本编辑效果
//- (NSAttributedString *)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component{
//    NSString * reStr = self.dataArry[row];
//    // 创建一个富文本
//    NSMutableAttributedString * attriStr = [[NSMutableAttributedString alloc] initWithString:reStr];
//    // 修改富文本中的不同文字的样式
//    [attriStr addAttribute:NSForegroundColorAttributeName value:YSColor(88, 164, 240) range:NSMakeRange(0, reStr.length)];
//    //[attriStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:NSMakeRange(0, reStr.length)];
//    ((UIView *)[self.pickView.subviews objectAtIndex:1]).backgroundColor = [YSColor(255, 255, 255) colorWithAlphaComponent:0.5];
//    return attriStr;
//}


@end

