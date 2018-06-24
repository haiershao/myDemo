//
//  LHSocketSender.m
//  CocoSocketDemo
//
//  Created by 海二少 on 2018/5/22.
//  Copyright © 2018年 LGQ. All rights reserved.
//

#import "LHSocketSender.h"
#import "LHSocketManager.h"
@implementation LHSocketSender
#pragma mark - 通用
/*
+ (void)sendData:(NSData *)data commandType:(LHPacketDataType)type withTimeout:(NSTimeInterval)timeout tag:(long)tag{
    if ([LHSocketManager shareSocketManager].connectState != LHSocketConnectState_ConnectSuccess) {
        return;
    }
    NSData *command = [LHPacketData packetDataWithData:data commandType:type];
    NSDictionary *dict = @{
                           @"data":command,
                           @"timeout":@(timeout),
                           @"tag":@(tag),
                           };
    [[LHSocketManager shareSocketManager] sendCommandWithCommandQueue:dict];
//    [[LHSocketManager shareSocketManager] sendCommand:command withTimeout:timeout tag:tag];
}
*/

+ (void)sendData:(NSData *)data withTimeout:(NSTimeInterval)timeout tag:(long)tag{
    if ([LHSocketManager shareSocketManager].connectState != LHSocketConnectState_ConnectSuccess) {
        return;
    }
    NSDictionary *dict = @{
                           @"data":data,
                           @"timeout":@(timeout),
                           @"tag":@(tag),
                           };
//    NSLog(@"sendCommandWithCommandQueue %@",data);
//    socketManager.sendHeart = NO;
    [[LHSocketManager shareSocketManager] sendCommandWithCommandQueue:dict];
}
@end
