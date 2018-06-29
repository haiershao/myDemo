//
//  LHConst.m
//  CocoSocketDemo
//
//  Created by 海二少 on 2018/6/5.
//  Copyright © 2018年 LGQ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

int const TypeUndefined = 0;
int const TypeCommand = 1;
int const TypeData = 2;
int const TypeResponse = 3;
int const TypeEvent = 4;

int const CanonVendorId = 0x04a9;
int const NikonVendorId = 0x04b0;

/*
 
 */
int const GetLiveViewPicture_p1 = 0x200000;

/*
 预览开启
 */
int const camera_previre_on = 2;

/*
 预览关闭
 */
int const camera_previre_off = 0;

/*
 获取USB信息
 */
int const Usb_info = 0x0002;

/*
 连接
 */
int const Camera_connect = 0x0001;

///*
// 获取deviceinfo
// */
//int const Device_info = 0x1001;
//
///*
// open_session
// */
//int const Open_session = 0x1002;

/*
 canon 04a9
 */
int const Canon = 1193;

/*
 500D cf31
 */
//int const Canon_type = 12751;
int const Canon_type = 12880;

/*
 nikon
 */
int const Nikon = 1200;

/*
 500D cf31
 */
//int const Nikon_type = ;

int const ExposureProgramModel_m = 0x0001;
int const ExposureProgramModel_program = 0x0002;
int const ExposureProgramModel_av = 0x0003;
int const ExposureProgramModel_tv = 0x0004;
int const ExposureProgramModel_auto = 0x8010;
int const ExposureProgramModel_portrait = 0x8011;
int const ExposureProgramModel_landscape = 0x8012;
int const ExposureProgramModel_close_up = 0x8013;
int const ExposureProgramModel_sports = 0x8014;
int const ExposureProgramModel_night_scene_portrait = 0x8015;
int const ExposureProgramModel_flash_off = 0x8016;
int const ExposureProgramModel_Child = 0x8017; // TODO Child
int const ExposureProgramModel_SCENE = 0x8018; // TODO SCENE
int const ExposureProgramModel_mode_U1 = 0x8050; // TODO User mode U1
int const ExposureProgramModel_mode_U2 = 0x8051; // TODO User mode U2

int const NikonWhitebalance_Auto             = 0x0002;
int const NikonWhitebalance_Sunny            = 0x0004;
int const NikonWhitebalance_Fluorescent      = 0x0005;
int const NikonWhitebalance_Incandescent     = 0x0006;
int const NikonWhitebalance_Flash            = 0x0007;
int const NikonWhitebalance_Cloudy           = 0x8010;
int const NikonWhitebalance_SunnyShade       = 0x8011;
int const NikonWhitebalance_ColorTemperature = 0x8012;
int const NikonWhitebalance_Preset           = 0x8013;

int const NikonFocusModelGetValue_AF_S = 0x8010;
int const NikonFocusModelGetValue_AF_C = 0x8011;
int const NikonFocusModelGetValue_AF_A = 0x8012;
int const NikonFocusModelGetValue_MF   = 0x8001;

int const NikonFocusModelSetValue_AF_S = 0x00;
int const NikonFocusModelSetValue_AF_C = 0x01;
int const NikonFocusModelSetValue_AF_A = 0x02;
int const NikonFocusModelSetValue_MF   = 0x04;




