//
//  SAVoucherAlertView.m
//  SkinAssistant
//
//  Created by 蔡路飞 on 2017/8/18.
//  Copyright © 2017年 LeGame. All rights reserved.
//

#import "SAVoucherAlertView.h"
#import "YWVoucherAlertViewCell.h"
@interface SAVoucherAlertView()<UITableViewDelegate,UITableViewDataSource>

@end
static NSString * const cellidenfder = @"YWVoucherAlertViewCell";
@implementation SAVoucherAlertView
+(instancetype)voucherAlertView {
    
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] lastObject];
}
-(void)awakeFromNib{
    
    [super awakeFromNib];
    
    [self setTable];
}

-(void)setTable{
    
//    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tableView.backgroundColor = [UIColor redColor];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.backgroundColor  =bagColor;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerNib:[UINib nibWithNibName:cellidenfder bundle:nil] forCellReuseIdentifier:cellidenfder];
   
    if (@available(iOS 11.0, *)) {
      
        
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        self.tableView.estimatedRowHeight = 0;
        self.tableView.estimatedSectionHeaderHeight = 0;
        self.tableView.estimatedSectionFooterHeight = 0;
    }
    
}



-(void)setVourcherModels:(NSMutableArray *)vourcherModels{
    _vourcherModels = vourcherModels;
    [self.tableView reloadData];
}


-(CGFloat)tableView:(UITableView*)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        return  0 ;
    }else{
        return 0.01f;
    }
    
}

-(CGFloat)tableView:(UITableView*)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01f;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return     _vourcherModels.count;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 80;
    
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SAVourcherModel * vourcherModel  = _vourcherModels[indexPath.row];
    YWVoucherAlertViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellidenfder];
    cell.vourcherModel = vourcherModel;
    return cell;
}

@end
