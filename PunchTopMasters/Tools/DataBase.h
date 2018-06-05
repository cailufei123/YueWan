//
//  DataBase.h
//  FMDBDemo
//
//  Created by Zeno on 16/5/18.
//  Copyright © 2016年 zenoV. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "SAMessageModel.h"


@interface DataBase : NSObject

@property(nonatomic,strong) SAMessageModel * messageModel;


+ (instancetype)sharedDataBase;


#pragma mark - Person
/**
 *  添加person
 *
 */
- (void)addMessage:(SAMessageModel *)messageModel;
/**
 *  删除person
 *
 */
- (void)deleteMessage:(SAMessageModel *)messageModel;
/**
 *  更新person
 *
 */
- (void)updateMessage:(SAMessageModel *)messageModel;

/**
 *  获取所有数据
 *
 */
- (NSMutableArray *)getAllMessage;
// 删除数据
- (void)deleteAllMessage;
/**
 *  查询
 *
 */


-(NSMutableArray*)selectitemDream_desc:(NSString *)msg_type;
-(NSMutableArray*)lookUpWith:(NSString *)extra1;

//标记全部已读
- (void)readMessage;
#pragma mark - Car

//
///**
// *  给person添加车辆
// *
// */
//- (void)addCar:(Car *)car toPerson:(Person *)person;
///**
// *  给person删除车辆
// *
// */
//- (void)deleteCar:(Car *)car fromPerson:(Person *)person;
///**
// *  获取person的所有车辆
// *
// */
//- (NSMutableArray *)getAllCarsFromPerson:(Person *)person;
///**
// *  删除person的所有车辆
// *
// */
//- (void)deleteAllCarsFromPerson:(Person *)person;
//

@end
