

//typedef NS_ENUM(NSInteger, Canon_Model) {
////    Canon_Model_Unknown,
//    Canon_Model_700D,
//};

#import "JYCamera.h"
#import "CameraModel.h"
@interface JYCanon : JYCamera

//型号
+ (NSArray *)canonModelSetting;
//光圈
+ (NSArray *)canonApertureWithModel:(Camera_Model)model;
//快门
+ (NSArray *)canonShutterSpeedWithModel:(Camera_Model)model;
//ISO
+ (NSArray *)canonISOWithModel:(Camera_Model)model;
//曝光补偿
+ (NSArray *)canonCompensationWithModel:(Camera_Model)model;
//焦距
+ (NSArray *)canonImageZoomWithModel:(Camera_Model)model;
//对焦变远
+ (NSArray *)canonFoucsFarWithModel:(Camera_Model)model;
//对焦变近
+ (NSArray *)canonFoucsNearWithModel:(Camera_Model)model;
//相机拍摄模式
+ (NSArray *)canonVideoModeWithModel:(Camera_Model)model;
//白平衡
+ (NSArray *)canonWhiteBalanceWithModel:(Camera_Model)model;
//录像模式开关
+ (NSArray *)canonVideoPowerSwitchWithModel:(Camera_Model)model;
//对焦
+ (NSArray *)canonFocusWithModel:(Camera_Model)model;

@end
