//
//  YWPriceBgView.m
//  PunchTopMasters
//
//  Created by 蔡路飞 on 2018/3/30.
//  Copyright © 2018年 蔡路飞. All rights reserved.
//

#import "YWPriceBgView.h"
@interface YWPriceBgView()<UITextFieldDelegate,UIScrollViewDelegate>
@property(nonatomic,strong) NSMutableArray * allPrices;

@property(nonatomic,strong) NSMutableArray * aaPrices;
@property(nonatomic,strong) NSMutableArray * xsPrices;
@property(nonatomic,strong) NSMutableArray * sbPrices;
@property(nonatomic,strong) NSMutableArray * buttons;
@property (strong, nonatomic) UITextField * textFile;
@property (strong, nonatomic) YWSelectButton * isSelectButton;
@end
@implementation YWPriceBgView
-(NSMutableArray *)buttons{
    
    if (!_buttons) {
        _buttons = [NSMutableArray array];
        
    }
    return _buttons;
}

-(instancetype)init{
    
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    
    self = [super initWithFrame:frame];
    if (self) {
        
          self.aaPrices = [NSMutableArray arrayWithObjects:@{@"number":@"0",@"name":@"10"},@{@"number":@"1",@"name":@"20"},@{@"number":@"2",@"name":@"30"},@{@"number":@"3",@"name":@"50"},@{@"number":@"4",@"name":@"100"},@{@"number":@"5",@"name":@"其他"}, nil];
        self.xsPrices = [NSMutableArray arrayWithObjects:@{@"number":@"0",@"name":@"5"},@{@"number":@"1",@"name":@"10"},@{@"number":@"2",@"name":@"20"},@{@"number":@"3",@"name":@"30"},@{@"number":@"4",@"name":@"50"},@{@"number":@"5",@"name":@"其他"}, nil];
          self.sbPrices = [NSMutableArray arrayWithObjects:@{@"number":@"0",@"name":@"1"},@{@"number":@"1",@"name":@"3"},@{@"number":@"2",@"name":@"5"},@{@"number":@"3",@"name":@"10"},@{@"number":@"4",@"name":@"0"},@{@"number":@"5",@"name":@"其他"}, nil];
        
        
         self.allPrices =  self.sbPrices;
        [self setup];
    }
    return self;
}
-(void)setStatusStr:(NSString *)statusStr{
    _statusStr = statusStr;
   
    if ([statusStr isEqualToString:@"1"]) {
        self.allPrices =  self.aaPrices;
    }else  if ([statusStr isEqualToString:@"2"]) {
          self.allPrices =  self.xsPrices;
    } if ([statusStr isEqualToString:@"3"]) {
          self.allPrices =  self.sbPrices;
    }
    for (int i = 0; i < self.buttons.count; i++) {
        YWSelectButton * button = self.buttons[i];
        [button setTitle:self.allPrices[i][@"name"] forState:UIControlStateNormal];
        button.selected = NO;
         self.isSelectButton.layer.borderColor = deepGrayColor.CGColor;
    }
    if (self.pirceStr) {
         self.pirceStr(@"");
    }
    
    
}
-(void)awakeFromNib {
    [super awakeFromNib];
    [self setup];
}
-(void)setup{
    
    [self createRquestBt];
}
//创建按钮
-(void)createRquestBt{
  
    //中间3个按钮
    int maxCols = 3;
    CGFloat buttonStartX = 0;
    CGFloat butttonStartY = 0;
    CGFloat xMargin = 15;
    CGFloat yMargin = 13;
    CGFloat buttonH = 36;
    CGFloat buttonW = (LFscreenW-72-(maxCols - 1) * xMargin - 2*buttonStartX)/maxCols;
   
    
    [self.buttons removeAllObjects];
    for (int i = 0; i < self.allPrices.count; i++) {
        NSString * number = self.allPrices[i][@"number"];
       
      
        //计算X、Y
        int row = i / maxCols;
        int col = i % maxCols;
        
        CGFloat buttonX = buttonStartX + col * (xMargin + buttonW);
        CGFloat buttonEndY = butttonStartY + row * (buttonH+yMargin);
        
        if ([number isEqualToString:@"5"]) {
            UITextField * textFile = [[UITextField alloc] init];
            textFile.delegate = self;
            self.textFile = textFile;
            textFile.keyboardType = UIKeyboardTypeNumberPad;
            textFile.backgroundColor = [UIColor whiteColor];
            textFile.layer.borderWidth = 0.5;
            textFile.textColor = publishTextColor;
            [textFile layercornerRadius:3];
            textFile.layer.borderColor = deepGrayColor.CGColor;
      
            textFile.placeholder = @"其他";
            [textFile setValue:publishTextColor forKeyPath:@"_placeholderLabel.textColor"];
            textFile.frame = CGRectMake(buttonX, buttonEndY, buttonW, buttonH);
            [self addSubview:textFile];
            textFile.textAlignment = NSTextAlignmentCenter;
            textFile.font = [UIFont systemFontOfSize:16];
            [self.textFile addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        }else{
            YWSelectButton * bt = [[YWSelectButton alloc] init];
            [self.buttons addObject:bt];
            [self selectBtStatus:bt];
            [bt setTitle:self.allPrices[i][@"name"] forState:UIControlStateNormal];
            bt.titleLabel.font = [UIFont systemFontOfSize:16];
            bt.tag = i;
            [bt setTitleColor:publishTextColor forState:UIControlStateNormal];
            [self addSubview:bt];
            [bt  addTarget:self action:@selector(clickBgBtClick:) forControlEvents:UIControlEventTouchUpInside];
            
            bt.frame = CGRectMake(buttonX, buttonEndY, buttonW, buttonH);
            
            
        }
        
    }
}

-(void)textFieldDidBeginEditing:(UITextField *)textField{
    textField.placeholder = @"";
//    textField.backgroundColor =[SVGloble colorWithHexString:@"#FECD1B"];
    
    textField.layer.borderColor = yellowBoderColor.CGColor;
    for (int i = 0; i<self.buttons.count; i++) {
        YWSelectButton * button = self.buttons[i];
        button.selected = NO;
        button.layer.borderColor = deepGrayColor.CGColor;

    }
}
-(void)selectBtStatus:(YWSelectButton *)bt{
    [bt layercornerRadius:3];
    bt.layer.borderColor = deepGrayColor.CGColor;
    bt.layer.borderWidth = 0.5;
 
    
}
-(void)clickBgBtClick:(YWSelectButton *)bt{
    self.isSelectButton.layer.borderColor = deepGrayColor.CGColor;
    self.isSelectButton.selected = NO;
    bt.selected = YES;
    self.isSelectButton = bt;
    bt.layer.borderColor = yellowBoderColor.CGColor;
    self.textFile.layer.borderColor = deepGrayColor.CGColor;
    self.textFile.text = @"";
    self.textFile.placeholder = @"其他";
    
    self.pirceStr(self.allPrices[bt.tag][@"name"]);
}
-(void)textFieldDidChange :(UITextField *)theTextField{
    if (theTextField.text.length==1) {
//        if ([theTextField.text integerValue] == 0) {
//            theTextField.text = @"";
//        }
    }
    if (theTextField.text.length>=5) {
        theTextField.text = @"9999";
        
    }
    
}
- (void)textFieldDidEndEditing:(UITextField *)textField{
     self.pirceStr(textField.text);
    NSLog(@"退出编辑模式");
    
}
@end
