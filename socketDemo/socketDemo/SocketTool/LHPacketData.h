//
//  LHPacketData.h
//  CocoSocketDemo
//
//  Created by 海二少 on 2018/5/28.
//  Copyright © 2018年 LGQ. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef NS_ENUM(NSInteger, LHPacketDataType) {
    LHPacketDataTypeText = 1, //文本
    LHPacketDataTypeImage,    //图片
    LHPacketDataTypeHex,      //16进制
    LHPacketDataTypeData,     //data
};

#define packetData [LHPacketData sharePacketData]
@interface LHPacketData : NSObject
@property (assign, nonatomic) long commandCountID;

+ (instancetype)sharePacketData;
/*
//封包
+ (NSData *)packetDataWithData:(NSData *)command commandType:(LHPacketDataType)packetDataType;

//心跳
+ (NSData *)heartBeatParam;

+ (NSData *)heartBeatParamWithData:(NSData *)data;
*/

+ (NSData *)encodeCommandHeartCode:(int)code;
+ (NSData *)encodeCommandCode:(int)code;
+ (NSData *)encodeCommandCode:(int)code param0:(int)p0;
+ (NSData *)encodeCommandCode:(int)code param1:(int)p1 param2:(int)p2;
+ (NSData *)encodeCommandCodeAndCommandData:(int)code param1:(int)p1 param2:(int)p2;
+ (NSData *)encodeCommandCode:(int)code param1:(int)p1 param2:(int)p2 param3:(int)p3;
+ (NSData *)encode_21NikonCommandCodeAndCommandData:(int)code param1:(int)p1 param2:(int)p2 param3:(short)p3;
+ (NSData *)encode_22NikonCommandCodeAndCommandData:(int)code param1:(int)p1 param2:(int)p2;
+ (NSData *)encode_22WBNikonCommandCodeAndCommandData:(int)code param1:(int)p1 param2:(int)p2;
+ (NSData *)encode_24ShutterNikonCommandCodeAndCommandData:(int)code param1:(int)p1 param2:(int)p2;
@end
