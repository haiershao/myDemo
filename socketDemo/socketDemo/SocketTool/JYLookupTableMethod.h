//
//  JYLookupTableMethod.h
//  socketDemo
//
//  Created by 海二少 on 2018/6/29.
//  Copyright © 2018年 海二少. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JYLookupTableMethod : NSObject
+ (void)apertureDefaultSelect:(NSString *)defaultStr andValuesArr:(NSArray *)valuesArr resultBlock:(void (^)(NSInteger selectIndex))resultBlock;
+ (void)shutterDefaultSelect:(NSString *)defaultStr andValuesArr:(NSArray *)valuesArr resultBlock:(void (^)(NSInteger selectIndex))resultBlock;
+ (void)exposureCompensationDefaultSelect:(NSString *)defaultStr andValuesArr:(NSArray *)valuesArr resultBlock:(void (^)(NSInteger selectIndex))resultBlock;
+ (void)ISODefaultSelect:(NSString *)defaultStr andValuesArr:(NSArray *)valuesArr resultBlock:(void (^)(NSInteger selectIndex))resultBlock;
+ (NSInteger)whiteBalanceDefaultSelect:(NSString *)defaultStr;
+ (NSInteger)afModelDefaultSelect:(NSString *)defaultStr;
+ (NSInteger)cameraModelDefaultSelect:(NSString *)defaultStr;

+ (NSString *)lockupShutterSpeedForValue:(int)value;
@end
