//
//  LHSocketSender.h
//  CocoSocketDemo
//
//  Created by 海二少 on 2018/5/22.
//  Copyright © 2018年 LGQ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LHConst.h"
#import "LHPacketData.h"
#import "LHSocketManager.h"
@interface LHSocketSender : NSObject
+ (void)sendHeartCommand;
+ (void)sendGetUSB_infoCommand;
+ (void)sendConnectCameraCommandWithCameraBrand:(int)cameraBrand cameraType:(int)cameraType;
+ (long)sendOpenSessionCommand;
+ (void)sendCloseSessionCommand;
+ (void)sendSnapInitiateCaptureCommand;
+ (void)sendGetThumbCommandWithParam:(int)param;
//+ (void)sendGetDevicePropDescCommand;
+ (void)sendNikonDeviceReadyCommand;//90c8
+ (void)sendGetPartialObjectCommand;
+ (void)sendGetObjectInfoCommandWithParam:(int)param;
+ (void)sendGetDevicePropValueCommandWithParam:(int)param;//1015

+ (void)sendPreviewNikonRecordingMediaCommmandWithParam0:(int)param0 param1:(int)param1 param2:(int)param2;//1016 21
+ (void)sendPreviewNikonChangeCameraModeCommand:(NikonPreviewType)previewType;//90c2
+ (void)sendGetDevicePropDescCommmandWithParam:(int)param;//1014
+ (void)sendPreviewExposureProgramModeCommmandWithParam0:(int)param0 param1:(int)param1;//1016 22
+ (void)sendPreviewNikonStartLiveViewCommand;//9201
+ (void)sendPreviewNikonGetLiveViewImageCommand;//9203
+ (void)sendPreviewNikonEndLiveViewCommand;
+ (void)sendNikonMfDriveWithParam0:(int)param0 param1:(int)param1;
+ (void)send_22NikonWithParam1:(int)param1 param2:(int)param2;

+ (void)sendData:(NSData *)data withTimeout:(NSTimeInterval)timeout tag:(long)tag;
@end
