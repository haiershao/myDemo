//
//  LHConst.h
//  CocoSocketDemo
//
//  Created by 海二少 on 2018/6/5.
//  Copyright © 2018年 LGQ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, NikonPreviewType) {
    NikonPreviewTypeOn  = 1,
    NikonPreviewTypeOff = 0,
};

UIKIT_EXTERN int const TypeUndefined;
UIKIT_EXTERN int const TypeCommand;
UIKIT_EXTERN int const TypeData;
UIKIT_EXTERN int const TypeResponse;
UIKIT_EXTERN int const TypeEvent;

/*
 厂商ID
 */
UIKIT_EXTERN int const CanonVendorId;
UIKIT_EXTERN int const NikonVendorId;

/*
 
 */
UIKIT_EXTERN int const GetLiveViewPicture_p1;

/*
 获取USB信息
 */
UIKIT_EXTERN int const camera_previre_on;

/*
 获取USB信息
 */
UIKIT_EXTERN int const camera_previre_off;

/*
 获取USB信息
 */
UIKIT_EXTERN int const Usb_info;

/*
 连接
 */
UIKIT_EXTERN int const Camera_connect;

///*
// 获取deviceinfo
// */
//UIKIT_EXTERN int Device_info;
//
///*
// open_session
// */
//UIKIT_EXTERN int const Open_session;

/*
 canon 04a9
 */
UIKIT_EXTERN int const Canon;

/*
 500D cf31
 */
UIKIT_EXTERN int const Canon_type;

/*
 nikon 04b0
 */
UIKIT_EXTERN int const Nikon;

UIKIT_EXTERN int const ExposureProgramModel_m;
UIKIT_EXTERN int const ExposureProgramModel_program;
UIKIT_EXTERN int const ExposureProgramModel_av;
UIKIT_EXTERN int const ExposureProgramModel_tv;
UIKIT_EXTERN int const ExposureProgramModel_auto;
UIKIT_EXTERN int const ExposureProgramModel_portrait;
UIKIT_EXTERN int const ExposureProgramModel_landscape;
UIKIT_EXTERN int const ExposureProgramModel_close_up;
UIKIT_EXTERN int const ExposureProgramModel_sports;
UIKIT_EXTERN int const ExposureProgramModel_night_scene_portrait;
UIKIT_EXTERN int const ExposureProgramModel_flash_off;
UIKIT_EXTERN int const ExposureProgramModel_Child; // TODO Child
UIKIT_EXTERN int const ExposureProgramModel_SCENE; // TODO SCENE
UIKIT_EXTERN int const ExposureProgramModel_mode_U1; // TODO User mode U1
UIKIT_EXTERN int const ExposureProgramModel_mode_U2; // TODO User mode U2

UIKIT_EXTERN int const NikonWhitebalance_Auto;
UIKIT_EXTERN int const NikonWhitebalance_Sunny;
UIKIT_EXTERN int const NikonWhitebalance_Fluorescent;
UIKIT_EXTERN int const NikonWhitebalance_Incandescent;
UIKIT_EXTERN int const NikonWhitebalance_Flash;
UIKIT_EXTERN int const NikonWhitebalance_Cloudy;
UIKIT_EXTERN int const NikonWhitebalance_SunnyShade;
UIKIT_EXTERN int const NikonWhitebalance_ColorTemperature;
UIKIT_EXTERN int const NikonWhitebalance_Preset;

//focus model
//AF-S  AF-C AF-A MF
UIKIT_EXTERN int const NikonFocusModelGetValue_AF_S;
UIKIT_EXTERN int const NikonFocusModelGetValue_AF_C;
UIKIT_EXTERN int const NikonFocusModelGetValue_AF_A;
UIKIT_EXTERN int const NikonFocusModelGetValue_MF;

UIKIT_EXTERN int const NikonFocusModelSetValue_AF_S;
UIKIT_EXTERN int const NikonFocusModelSetValue_AF_C;
UIKIT_EXTERN int const NikonFocusModelSetValue_AF_A;
UIKIT_EXTERN int const NikonFocusModelSetValue_MF;

