//
//  LHSocketSender.m
//  CocoSocketDemo
//
//  Created by 海二少 on 2018/5/22.
//  Copyright © 2018年 LGQ. All rights reserved.
//

#import "LHSocketSender.h"
#import "LHSocketManager.h"
#import "LHSocketOperation.h"
#import "LHSocketResponse.h"
#import "LHSocketProperty.h"
@implementation LHSocketSender
+ (void)sendHeartCommand{
    NSData *data = [LHPacketData encodeCommandCode:NikonGetEvent];
    [LHSocketSender sendData:data withTimeout:-1 tag:111];
}

+ (void)sendGetUSB_infoCommand{
    socketManager.sendHeart = NO;
    //Nikon 0423
    //1000 0000 0c00 0000 0100 0200 0100 0000
    //1000 0000 0c00 0000 0100 0200 0100 0000
    NSData *data = [LHPacketData encodeCommandCode:Usb_info];
    [LHSocketSender sendData:data withTimeout:-1 tag:110];
}

+ (void)sendConnectCameraCommandWithCameraBrand:(int)cameraBrand cameraType:(int)cameraType{
    [LHSocketManager shareSocketManager].sendHeart = NO;
    //连接相机
    NSData *connectData = [LHPacketData encodeCommandCode:Camera_connect param1:cameraBrand param2:cameraType];
    [LHSocketSender sendData:connectData withTimeout:-1 tag:110];
}

+ (long)sendOpenSessionCommand{
    //打开会话
    [LHSocketManager shareSocketManager].sendHeart = NO;
    NSData *opensessionData = [LHPacketData encodeCommandCode:OpenSession param0:1];
//    _openSessionID = packetData.commandCountID;
    [LHSocketSender sendData:opensessionData withTimeout:-1 tag:110];
    return packetData.commandCountID;
}

+ (void)sendCloseSessionCommand{
    //关闭会话
    [LHSocketManager shareSocketManager].sendHeart = NO;
    NSData *closesessionData = [LHPacketData encodeCommandCode:CloseSession param0:0];
    [LHSocketSender sendData:closesessionData withTimeout:-1 tag:110];
}

+ (void)sendSnapInitiateCaptureCommand{
    [LHSocketManager shareSocketManager].sendHeart = NO;
    NSData *data = [LHPacketData encodeCommandCode:InitiateCapture];
    NSLog(@"拍照InitiateCapture>>> %@",data);
    [LHSocketSender sendData:data withTimeout:-1 tag:110];
}

+ (void)sendGetThumbCommandWithParam:(int)param{//0x29194005
    [LHSocketManager shareSocketManager].sendHeart = NO;
    NSData *data = [LHPacketData encodeCommandCode:GetThumb param0:param];
    NSLog(@"拍照snapGetThumb>>> %@",data);
    [LHSocketSender sendData:data withTimeout:-1 tag:110];
}

+ (void)sendGetDevicePropDescCommand{
    [LHSocketManager shareSocketManager].sendHeart = NO;
    NSData *data = [LHPacketData encodeCommandCode:GetDevicePropDesc param0:0xd108];//0xd108
    NSLog(@"拍照GetDevicePropDesc>>> %@",data);
    [LHSocketSender sendData:data withTimeout:-1 tag:110];
}

+ (void)sendNikonDeviceReadyCommand{
    [LHSocketManager shareSocketManager].sendHeart = NO;
    NSData *data = [LHPacketData encodeCommandCode:NikonDeviceReady];
    NSLog(@"拍照NikonDeviceReady>>> %@",data);
    [LHSocketSender sendData:data withTimeout:-1 tag:110];
}

+ (void)sendGetPartialObjectCommand{
    [LHSocketManager shareSocketManager].sendHeart = NO;
    NSData *data = [LHPacketData encodeCommandCode:GetPartialObject param1:0x29194015 param2:0x0 param3:0x00100000];
    NSLog(@"拍照snapGetPartialObject>>> %@",data);
    [LHSocketSender sendData:data withTimeout:-1 tag:110];
}

+ (void)sendGetObjectInfoCommandWithParam:(int)param{
    [LHSocketManager shareSocketManager].sendHeart = NO;
    NSData *data = [LHPacketData encodeCommandCode:GetObjectInfo param0:param];
    NSLog(@"拍照snapGetObjectInfo>>> %@",data);
    [LHSocketSender sendData:data withTimeout:-1 tag:110];
}

+ (void)sendGetDevicePropValueCommandWithParam:(int)param{
    [LHSocketManager shareSocketManager].sendHeart = NO;
    NSData *data = [LHPacketData encodeCommandCode:GetDevicePropValue param0:param];
    NSLog(@"GetDevicePropValue>>> %@",data);
    [LHSocketSender sendData:data withTimeout:-1 tag:110];
}

+ (void)sendPreviewNikonRecordingMediaCommmandWithParam0:(int)param0 param1:(int)param1 param2:(int)param2{//NikonRecordingMedia 0x0d 1
    [LHSocketManager shareSocketManager].sendHeart = NO;
    NSData *data = [LHPacketData encode_21NikonCommandCodeAndCommandData:SetDevicePropValue param1:param0 param2:param1 param3:param2];
    NSLog(@"预览NikonRecordingMedia>>> %@",data);
    [LHSocketSender sendData:data withTimeout:-1 tag:110];
//    NSData *data = [LHPacketData encodeCommandCode:GetDevicePropDesc param0:ExposureProgramMode];
//    NSLog(@"预览GetDevicePropDesc>>> %@",data);
//    [LHSocketSender sendData:data withTimeout:-1 tag:110];
}

+ (void)sendPreviewNikonChangeCameraModeCommand:(NikonPreviewType)previewType{
    [LHSocketManager shareSocketManager].sendHeart = NO;
    NSData *data = [LHPacketData encodeCommandCode:NikonChangeCameraMode param0:previewType];
    NSLog(@"预览NikonStartLiveView>>> %@",data);
    [LHSocketSender sendData:data withTimeout:-1 tag:110];
}

+ (void)sendGetDevicePropDescCommmandWithParam:(int)param{
    [LHSocketManager shareSocketManager].sendHeart = NO;
    NSData *data = [LHPacketData encodeCommandCode:GetDevicePropDesc param0:param];
    NSLog(@"预览GetDevicePropDesc>>> %@",data);
    [LHSocketSender sendData:data withTimeout:-1 tag:110];
}

+ (void)sendPreviewExposureProgramModeCommmandWithParam0:(int)param0 param1:(int)param1{
    [LHSocketManager shareSocketManager].sendHeart = NO;
    NSData *data = [LHPacketData encode_22NikonCommandCodeAndCommandData:SetDevicePropValue param1:param0 param2:param1];
    NSLog(@"预览ExposureProgramMode>>> %@",data);
    [LHSocketSender sendData:data withTimeout:-1 tag:110];
}

+ (void)sendPreviewNikonStartLiveViewCommand{
    [LHSocketManager shareSocketManager].sendHeart = NO;
    NSData *data = [LHPacketData encodeCommandCode:NikonStartLiveView];
    NSLog(@"预览NikonStartLiveView>>> %@",data);
    [LHSocketSender sendData:data withTimeout:-1 tag:110];
}

+ (void)sendPreviewNikonGetLiveViewImageCommand{
    [LHSocketManager shareSocketManager].sendHeart = NO;
    NSData *data = [LHPacketData encodeCommandCode:NikonGetLiveViewImage];
    NSLog(@"预览GetLiveViewImage>>> %@",data);
    [LHSocketSender sendData:data withTimeout:-1 tag:110];
}

+ (void)sendPreviewNikonEndLiveViewCommand{
    [LHSocketManager shareSocketManager].sendHeart = NO;
    NSData *data = [LHPacketData encodeCommandCode:NikonEndLiveView];
    NSLog(@"预览NikonEndLiveView>>> %@",data);
    [LHSocketSender sendData:data withTimeout:-1 tag:110];
}

+ (void)sendNikonMfDriveWithParam0:(int)param0 param1:(int)param1{
    [LHSocketManager shareSocketManager].sendHeart = NO;
    NSData *data = [LHPacketData encodeCommandCode:NikonMfDrive param1:param0 param2:param1];
    NSLog(@"focalLengthLeft2ButtonClick %@",data);
    [LHSocketSender sendData:data withTimeout:-1 tag:110];
}

+ (void)send_22NikonWithParam1:(int)param1 param2:(int)param2{
    [LHSocketManager shareSocketManager].sendHeart = NO;
    NSData *data = [LHPacketData encode_22WBNikonCommandCodeAndCommandData:SetDevicePropValue param1:param1 param2:param2];
    NSLog(@"WB>>> %@",data);
    [LHSocketSender sendData:data withTimeout:-1 tag:110];
}














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
