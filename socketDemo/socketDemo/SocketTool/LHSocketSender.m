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
    NSLog(@"send_22NikonWithParam1>>> %@",data);
    [LHSocketSender sendData:data withTimeout:-1 tag:110];
}

+ (void)send_24NikonWithParam1:(int)param1 param2:(int)param2{
    [LHSocketManager shareSocketManager].sendHeart = NO;
    NSData *data = [LHPacketData encode_24ShutterNikonCommandCodeAndCommandData:SetDevicePropValue param1:param1 param2:param2];
    NSLog(@"send_24NikonWithParam1>>> %@",data);
    [LHSocketSender sendData:data withTimeout:-1 tag:110];
}

+ (void)selectItemForShutterSpeed:(NSArray *)valueArr selectIndex:(NSInteger)selectIndex{
    NSString *tempStr = valueArr[selectIndex];
    int value = 0;
    int param = 0;
    if ([tempStr containsString:@"/"]&&![tempStr containsString:@"."]) {
        tempStr = [tempStr componentsSeparatedByString:@"/"].lastObject;
        value = [tempStr intValue];
        param = 65536 + value;
    }else if ([tempStr containsString:@"."]){
        NSString *firstStr = @"";
        NSString *lastStr = @"";
        int firstValue = 0;
        int lastValue = 0;
        firstStr = [tempStr componentsSeparatedByString:@"."].firstObject;
        firstStr = [firstStr componentsSeparatedByString:@"/"].lastObject;
        lastStr = [tempStr componentsSeparatedByString:@"."].lastObject;
        firstValue = [firstStr intValue];
        lastValue = [lastStr intValue];
        param = 65536*10+firstValue*10+lastValue;
        //            NSLog(@"%@--%@--%d--%d",firstStr,lastStr,firstValue,lastValue);
    }else if ([tempStr isEqualToString:@"bulb"]){
        param = 0xffffffff;
    }else{
        value = [tempStr intValue];
        if (0 == value) {
            param = 65536+1;
        }else{
            param = value*65536+1;
        }
    }
    //        NSLog(@"basePickerView>>> %@ -- %d -- %d",tempStr, value,param);
    [LHSocketSender send_24NikonWithParam1:NikonShutterSpeed param2:param];
    [LHSocketSender sendGetDevicePropDescCommmandWithParam:NikonShutterSpeed];
    
}

+ (void)selectItemForWB:(NSInteger)selectIndex{
    if (0 == selectIndex) {
        [LHSocketSender send_22NikonWithParam1:WhiteBalance param2:NikonWhitebalance_Auto];
        [LHSocketSender sendGetDevicePropDescCommmandWithParam:WhiteBalance];
    }else if (1 == selectIndex){
        [LHSocketSender send_22NikonWithParam1:WhiteBalance param2:NikonWhitebalance_Sunny];
        [LHSocketSender sendGetDevicePropDescCommmandWithParam:WhiteBalance];
    }else if (2 == selectIndex){
        [LHSocketSender send_22NikonWithParam1:WhiteBalance param2:NikonWhitebalance_Fluorescent];
        [LHSocketSender sendGetDevicePropDescCommmandWithParam:WhiteBalance];
    }else if (3 == selectIndex){
        [LHSocketSender send_22NikonWithParam1:WhiteBalance param2:NikonWhitebalance_Incandescent];
        [LHSocketSender sendGetDevicePropDescCommmandWithParam:WhiteBalance];
    }else if (4 == selectIndex){
        [LHSocketSender send_22NikonWithParam1:WhiteBalance param2:NikonWhitebalance_Flash];
        [LHSocketSender sendGetDevicePropDescCommmandWithParam:WhiteBalance];
    }else if (5 == selectIndex){
        [LHSocketSender send_22NikonWithParam1:WhiteBalance param2:NikonWhitebalance_Cloudy];
        [LHSocketSender sendGetDevicePropDescCommmandWithParam:WhiteBalance];
    }else if (6 == selectIndex){
        [LHSocketSender send_22NikonWithParam1:WhiteBalance param2:NikonWhitebalance_SunnyShade];
        [LHSocketSender sendGetDevicePropDescCommmandWithParam:WhiteBalance];
    }else if (7 == selectIndex){
        [LHSocketSender send_22NikonWithParam1:WhiteBalance param2:NikonWhitebalance_ColorTemperature];
        [LHSocketSender sendGetDevicePropDescCommmandWithParam:WhiteBalance];
    }else if (8 == selectIndex){
        [LHSocketSender send_22NikonWithParam1:WhiteBalance param2:NikonWhitebalance_Preset];
        [LHSocketSender sendGetDevicePropDescCommmandWithParam:WhiteBalance];
    }
}

+ (void)selectItemForAFModel:(NSInteger)selectIndex{
    if (0 == selectIndex) {
        [LHSocketSender sendPreviewNikonRecordingMediaCommmandWithParam0:FocusModeSetValue param1:0x0d param2:NikonFocusModelSetValue_AF_S];//AF-S
    }else if (1 == selectIndex){
        [LHSocketSender sendPreviewNikonRecordingMediaCommmandWithParam0:FocusModeSetValue param1:0x0d param2:NikonFocusModelSetValue_AF_C];//AF-C
    }else if (2 == selectIndex){
        [LHSocketSender sendPreviewNikonRecordingMediaCommmandWithParam0:FocusModeSetValue param1:0x0d param2:NikonFocusModelSetValue_AF_A];//AF-A
    }else if (3 == selectIndex){
        [LHSocketSender sendPreviewNikonRecordingMediaCommmandWithParam0:FocusModeSetValue param1:0x0d param2:NikonFocusModelSetValue_MF];//MF
    }else if (4 == selectIndex){
        [LHSocketSender sendPreviewNikonRecordingMediaCommmandWithParam0:FocusModeSetValue param1:0x0d param2:0x03];
    }
}

+ (void)selectItemForExposureBiasCompensation:(NSArray *)valueArr selectIndex:(NSInteger)selectIndex{
    NSString *tempStr = valueArr[selectIndex];
    NSString *firstStr = @"";
    NSString *lastStr = @"";
    int firstValue = 0;
    int lastValue = 0;
    int param = 0;
    if ([tempStr containsString:@"-"]) {
        tempStr = [tempStr componentsSeparatedByString:@"-"].lastObject;
        firstStr = [tempStr componentsSeparatedByString:@"."].firstObject;
        lastStr = [tempStr componentsSeparatedByString:@"."].lastObject;
        firstValue = [firstStr intValue];
        lastValue = [lastStr intValue];
        if (![tempStr containsString:@"."]) {
            param = 65536-firstValue*1000;
        }else{
            if (7 == lastValue) {
                lastValue = lastValue - 1;
            }
            param = 65536-(firstValue*1000+lastValue*100+lastValue*10+lastValue);
        }
    }else{
        firstStr = [tempStr componentsSeparatedByString:@"."].firstObject;
        lastStr = [tempStr componentsSeparatedByString:@"."].lastObject;
        firstValue = [firstStr intValue];
        lastValue = [lastStr intValue];
        if (![tempStr containsString:@"."]) {
            param = firstValue*1000;
        }else{
            if (7 == lastValue) {
                lastValue = lastValue - 1;
            }
            param = firstValue*1000+lastValue*100+lastValue*10+lastValue;
        }
    }
    [LHSocketSender send_22NikonWithParam1:ExposureBiasCompensation param2:param];
    [LHSocketSender sendGetDevicePropDescCommmandWithParam:ExposureBiasCompensation];
}

+ (void)selectItemForExposureProgramMode:(NSInteger)selectIndex{
    if (0 == selectIndex) {
        [LHSocketSender send_22NikonWithParam1:ExposureProgramMode param2:ExposureProgramModel_m];
        [LHSocketSender sendGetDevicePropDescCommmandWithParam:ExposureProgramMode];
    }else if (1 == selectIndex){
        [LHSocketSender send_22NikonWithParam1:ExposureProgramMode param2:ExposureProgramModel_program];
        [LHSocketSender sendGetDevicePropDescCommmandWithParam:ExposureProgramMode];
    }else if (2 == selectIndex){
        [LHSocketSender send_22NikonWithParam1:ExposureProgramMode param2:ExposureProgramModel_av];
        [LHSocketSender sendGetDevicePropDescCommmandWithParam:ExposureProgramMode];
    }else if (3 == selectIndex){
        [LHSocketSender send_22NikonWithParam1:ExposureProgramMode param2:ExposureProgramModel_tv];
        [LHSocketSender sendGetDevicePropDescCommmandWithParam:ExposureProgramMode];
    }else if (4 == selectIndex){
        [LHSocketSender send_22NikonWithParam1:ExposureProgramMode param2:ExposureProgramModel_auto];
        [LHSocketSender sendGetDevicePropDescCommmandWithParam:ExposureProgramMode];
    }else if (5 == selectIndex){
        [LHSocketSender send_22NikonWithParam1:ExposureProgramMode param2:ExposureProgramModel_portrait];
        [LHSocketSender sendGetDevicePropDescCommmandWithParam:ExposureProgramMode];
    }else if (6 == selectIndex){
        [LHSocketSender send_22NikonWithParam1:ExposureProgramMode param2:ExposureProgramModel_landscape];
        [LHSocketSender sendGetDevicePropDescCommmandWithParam:ExposureProgramMode];
    }else if (7 == selectIndex){
        [LHSocketSender send_22NikonWithParam1:ExposureProgramMode param2:ExposureProgramModel_close_up];
        [LHSocketSender sendGetDevicePropDescCommmandWithParam:ExposureProgramMode];
    }else if (8 == selectIndex){
        [LHSocketSender send_22NikonWithParam1:ExposureProgramMode param2:ExposureProgramModel_sports];
        [LHSocketSender sendGetDevicePropDescCommmandWithParam:ExposureProgramMode];
    }else if (9 == selectIndex){
        [LHSocketSender send_22NikonWithParam1:ExposureProgramMode param2:ExposureProgramModel_night_scene_portrait];
        [LHSocketSender sendGetDevicePropDescCommmandWithParam:ExposureProgramMode];
    }else if (10 == selectIndex){
        [LHSocketSender send_22NikonWithParam1:ExposureProgramMode param2:ExposureProgramModel_flash_off];
        [LHSocketSender sendGetDevicePropDescCommmandWithParam:ExposureProgramMode];
    }else if (11 == selectIndex){
        [LHSocketSender send_22NikonWithParam1:ExposureProgramMode param2:ExposureProgramModel_Child];
        [LHSocketSender sendGetDevicePropDescCommmandWithParam:ExposureProgramMode];
    }else if (12 == selectIndex){
        [LHSocketSender send_22NikonWithParam1:ExposureProgramMode param2:ExposureProgramModel_SCENE];
        [LHSocketSender sendGetDevicePropDescCommmandWithParam:ExposureProgramMode];
    }else if (13 == selectIndex){
        [LHSocketSender send_22NikonWithParam1:ExposureProgramMode param2:ExposureProgramModel_mode_U1];
        [LHSocketSender sendGetDevicePropDescCommmandWithParam:ExposureProgramMode];
    }else if (14 == selectIndex){
        [LHSocketSender send_22NikonWithParam1:ExposureProgramMode param2:ExposureProgramModel_mode_U2];
        [LHSocketSender sendGetDevicePropDescCommmandWithParam:ExposureProgramMode];
    }
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
