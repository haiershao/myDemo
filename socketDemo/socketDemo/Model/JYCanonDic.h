

#import <Foundation/Foundation.h>

@interface JYCanonDic : NSObject

//光圈
+ (NSString *)ApertureTitle:(Byte)type;

//快门
+ (NSString *)ShutterSpeedTitle:(Byte)type;

//ISO
+ (NSString *)ISOTitle:(Byte)type;

//曝光补偿
+ (NSString *)CompensationTitle:(Byte)type;

//相机模式
+ (NSString *)ModeTitle:(Byte)type;

//白平衡
+ (NSString *)WhiteBalanceTitle:(Byte)type;

//Picture Style Title
+ (NSString *)PictureStyleTitle:(Byte)type;

@end
