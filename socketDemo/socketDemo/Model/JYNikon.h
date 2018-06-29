
//typedef NS_ENUM(NSInteger, Nikon_Model) {
////    Nikon_Model_Unknown,
//    Nikon_Model_D7200,
//    Nikon_Model_D5300,
//};

#import "JYCamera.h"
#import "CameraModel.h"
@interface JYNikon : JYCamera

//型号
+ (NSArray *)nikonModelSetting;
//光圈
+ (NSArray *)nikonApertureWithModel;
//快门
+ (NSArray *)nikonShutterSpeedWithModel;
//ISO
+ (NSArray *)nikonISOWithModel;
//曝光补偿
+ (NSArray *)nikonCompensationWithModel;
//焦距
+ (NSArray *)nikonImageZoomWithModel:(Camera_Model)model;
+ (NSArray *)nikonExposureProgramModel;
+ (NSArray *)nikonAFModel;
//暂不支持对焦
////对焦变远
//+ (NSArray *)nikonFoucsFarWithModel:(Camera_Model)model;
////对焦变近
//+ (NSArray *)nikonFoucsNearWithModel:(Camera_Model)model;


//相机拍摄模式
+ (NSArray *)nikonVideoModeWithModel:(Camera_Model)model;
//白平衡
+ (NSArray *)nikonWhiteBalanceWithModel;

////录像模式开关
//+ (NSArray *)nikonVideoPowerSwitchWithModel:(Camera_Model)model;

//USB连接开关
+ (NSArray *)nikonUSBConnectSwitchWithModel:(Camera_Model)model;

@end
