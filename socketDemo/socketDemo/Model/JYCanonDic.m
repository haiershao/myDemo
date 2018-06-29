

#import "JYCanonDic.h"

@implementation JYCanonDic

//光圈
+ (NSString *)ApertureTitle:(Byte)type
{
    switch (type) {
        case 0x00:
            return @"0";
            break;
            
        case 0x08:
            return @"1";
            break;
            
        case 0x0B:
            return @"1.1";
            break;
            
//        case 0x0C:
//            return @"1.2";
//            break;
            
        case 0x0D:
            return @"1.2";
            break;
            
        case 0x10:
            return @"1.4";
            break;
            
        case 0x13:
            return @"1.6";
            break;
            
//        case 0x14:
//            return @"1.8";
//            break;
            
        case 0x15:
            return @"1.8";
            break;
            
        case 0x18:
            return @"2.0";
            break;
            
        case 0x1B:
            return @"2.2";
            break;
            
//        case 0x1C:
//            return @"2.5";
//            break;
            
        case 0x1D:
            return @"2.5";
            break;
            
        case 0x20:
            return @"2.8";
            break;
            
        case 0x23:
            return @"3.2";
            break;
            
//        case 0x24:
//            return @"3.5";
//            break;
            
        case 0x25:
            return @"3.5";
            break;
            
        case 0x28:
            return @"4.0";
            break;
            
        case 0x2B:
            return @"4.5";
            break;
            
//        case 0x2C:
//            return @"4.5";
//            break;
            
        case 0x2D:
            return @"5.0";
            break;
            
        case 0x30:
            return @"5.6";
            break;
            
        case 0x33:
            return @"6.3";
            break;
            
        case 0x34:
            return @"6.7";
            break;
            
        case 0x35:
            return @"7.1";
            break;
            
        case 0x38:
            return @"8.0";
            break;
            
        case 0x3B:
            return @"9.0";
            break;
            
        case 0x3C:
            return @"9.5";
            break;
            
        case 0x3D:
            return @"10";
            break;
            
        case 0x40:
            return @"11";
            break;
            
        case 0x43:
            return @"13";
            break;
            
//        case 0x44:
//            return @"13";
//            break;
            
        case 0x45:
            return @"14";
            break;
            
        case 0x48:
            return @"16";
            break;
            
        case 0x4B:
            return @"18";
            break;
            
        case 0x4C:
            return @"19";
            break;
            
        case 0x4D:
            return @"20";
            break;
            
        case 0x50:
            return @"22";
            break;
            
        case 0x53:
            return @"25";
            break;
            
        case 0x54:
            return @"27";
            break;
            
        case 0x55:
            return @"29";
            break;
            
        case 0x58:
            return @"32";
            break;
            
        case 0x5B:
            return @"36";
            break;
            
        case 0x5C:
            return @"38";
            break;
            
        case 0x5D:
            return @"40";
            break;
            
        case 0x60:
            return @"45";
            break;
            
        case 0x63:
            return @"51";
            break;
            
        case 0x64:
            return @"54";
            break;
            
        case 0x65:
            return @"57";
            break;
            
        case 0x68:
            return @"64";
            break;
            
        case 0x6B:
            return @"72";
            break;
            
        case 0x6C:
            return @"76";
            break;
            
        case 0x6D:
            return @"80";
            break;
            
        case 0x70:
            return @"91";
            break;
            
        default:
            break;
    }
    return nil;
}

//快门
+ (NSString *)ShutterSpeedTitle:(Byte)type
{
    switch (type) {
        case 0x0C:
            return @"Bulb";
            break;
            
        case 0x10:
            return @"30";
            break;
            
        case 0x13:
            return @"25";
            break;
            
//        case 0x14:
//            return @"20";
//            break;
            
        case 0x15:
            return @"20";
            break;
            
        case 0x18:
            return @"15";
            break;
            
        case 0x1B:
            return @"13";
            break;
            
//        case 0x1C:
//            return @"10";
//            break;
            
        case 0x1D:
            return @"10";
            break;
            
        case 0x20:
            return @"8";
            break;
            
        case 0x23:
            return @"6";
            break;
            
//        case 0x24:
//            return @"6";
//            break;
            
        case 0x25:
            return @"5";
            break;
            
        case 0x28:
            return @"4";
            break;
            
        case 0x2B:
            return @"3.2";
            break;
            
        case 0x2C:
            return @"3";
            break;
            
        case 0x2D:
            return @"2.5";
            break;
            
        case 0x30:
            return @"2";
            break;
            
        case 0x33:
            return @"1.6";
            break;
            
        case 0x34:
            return @"1.5";
            break;
            
        case 0x35:
            return @"1.3";
            break;
            
        case 0x38:
            return @"1";
            break;
            
        case 0x3B:
            return @"0.8";
            break;
            
        case 0x3C:
            return @"0.7";
            break;
            
        case 0x3D:
            return @"0.6";
            break;
            
        case 0x40:
            return @"0.5";
            break;
            
        case 0x43:
            return @"0.4";
            break;
            
//        case 0x44:
//            return @"0.3";
//            break;
            
        case 0x45:
            return @"0.3";
            break;
            
        case 0x48:
            return @"1/4";
            break;
            
        case 0x4B:
            return @"1/5";
            break;
            
//        case 0x4C:
//            return @"1/6";
//            break;
            
        case 0x4D:
            return @"1/6";
            break;
            
        case 0x50:
            return @"1/8";
            break;
            
        case 0x53:
            return @"1/10";
            break;
            
//        case 0x54:
//            return @"1/10";
//            break;
            
        case 0x55:
            return @"1/13";
            break;
            
        case 0x58:
            return @"1/15";
            break;
            
        case 0x5B:
            return @"1/20";
            break;
            
//        case 0x5C:
//            return @"1/20";
//            break;
            
        case 0x5D:
            return @"1/25";
            break;
            
        case 0x60:
            return @"1/30";
            break;
            
        case 0x63:
            return @"1/40";
            break;
            
        case 0x64:
            return @"1/45";
            break;
            
        case 0x65:
            return @"1/50";
            break;
            
        case 0x68:
            return @"1/60";
            break;
            
        case 0x6B:
            return @"1/80";
            break;
            
        case 0x6C:
            return @"1/90";
            break;
            
        case 0x6D:
            return @"1/100";
            break;
            
        case 0x70:
            return @"1/125";
            break;
            
        case 0x73:
            return @"1/160";
            break;
            
        case 0x74:
            return @"1/180";
            break;
            
        case 0x75:
            return @"1/200";
            break;
            
        case 0x78:
            return @"1/250";
            break;
            
        case 0x7B:
            return @"1/320";
            break;
            
        case 0x7C:
            return @"1/350";
            break;
            
        case 0x7D:
            return @"1/400";
            break;
            
        case 0x80:
            return @"1/500";
            break;
            
        case 0x83:
            return @"1/640";
            break;
            
        case 0x84:
            return @"1/750";
            break;
            
        case 0x85:
            return @"1/800";
            break;
            
        case 0x88:
            return @"1/1000";
            break;
            
        case 0x8B:
            return @"1/1250";
            break;
            
        case 0x8C:
            return @"1/1500";
            break;
            
        case 0x8D:
            return @"1/1600";
            break;
            
        case 0x90:
            return @"1/2000";
            break;
            
        case 0x93:
            return @"1/2500";
            break;
            
        case 0x94:
            return @"1/3000";
            break;
            
        case 0x95:
            return @"1/3200";
            break;
            
        case 0x98:
            return @"1/4000";
            break;
            
        case 0x9A:
            return @"1/5000";
            break;
            
        case 0x9C:
            return @"1/6000";
            break;
            
        case 0x9D:
            return @"1/6400";
            break;
            
        case 0xA0:
            return @"1/8000";
            break;
            
        default:
            break;
    }
    return nil;
}

//ISO
+ (NSString *)ISOTitle:(Byte)type
{
    switch (type) {
        case 0x00:
            return @"Auto";
            break;
            
        case 0x28:
            return @"6";
            break;
            
        case 0x30:
            return @"12";
            break;
            
        case 0x38:
            return @"25";
            break;
            
        case 0x40:
            return @"50";
            break;
            
        case 0x48:
            return @"100";
            break;
            
        case 0x4B:
            return @"125";
            break;
            
        case 0x4D:
            return @"160";
            break;
            
        case 0x50:
            return @"200";
            break;
            
        case 0x53:
            return @"250";
            break;
            
        case 0x55:
            return @"320";
            break;
            
        case 0x58:
            return @"400";
            break;
            
        case 0x5B:
            return @"500";
            break;
            
        case 0x5D:
            return @"640";
            break;
            
        case 0x60:
            return @"800";
            break;
            
        case 0x63:
            return @"1000";
            break;
            
        case 0x65:
            return @"1250";
            break;
            
        case 0x68:
            return @"1600";
            break;
            
        case 0x6B:
            return @"2000";
            break;
            
        case 0x6D:
            return @"2500";
            break;
            
        case 0x70:
            return @"3200";
            break;
            
        case 0x73:
            return @"4000";
            break;
            
        case 0x75:
            return @"5000";
            break;
            
        case 0x78:
            return @"6400";
            break;
            
        case 0x7B:
            return @"8000";
            break;
            
        case 0x7D:
            return @"10000";
            break;
            
        case 0x80:
            return @"12800";
            break;
            
        case 0x83:
            return @"16000";
            break;
            
        case 0x85:
            return @"20000";
            break;
            
        case 0x88:
            return @"25600";
            break;
            
        default:
            break;
    }
    return nil;
}

//曝光补偿39
+ (NSString *)CompensationTitle:(Byte)type
{
    switch (type) {
        case 0x28:
            return @"5";
            break;
            
        case 0x25:
            return @"14/3";
            break;
            
        case 0x23:
            return @"13/3";
            break;
            
        case 0x20:
            return @"4";
            break;
            
        case 0x1D:
            return @"11/3";
            break;
            
        case 0x1B:
            return @"10/3";
            break;
            
        case 0x18:
            return @"3";
            break;
            
        case 0x15:
            return @"8/3";
            break;
            
        case 0x14:
            return @"5/2";
            break;
            
        case 0x13:
            return @"7/3";
            break;
            
        case 0x10:
            return @"2";
            break;
            
        case 0x0D:
            return @"5/3";
            break;
            
        case 0x0C:
            return @"3/2";
            break;
            
        case 0x0B:
            return @"4/3";
            break;
            
        case 0x08:
            return @"1";
            break;
            
        case 0x05:
            return @"2/3";
            break;
            
        case 0x04:
            return @"1/2";
            break;
            
        case 0x03:
            return @"1/3";
            break;
            
        case 0x00:
            return @"0";
            break;
            
        case 0xFD:
            return @"-1/3";
            break;
            
        case 0xFC:
            return @"-1/2";
            break;
            
        case 0xFB:
            return @"-2/3";
            break;
            
        case 0xF8:
            return @"-1";
            break;
            
        case 0xF5:
            return @"-4/3";
            break;
            
        case 0xF4:
            return @"-3/2";
            break;
            
        case 0xF3:
            return @"-5/3";
            break;
            
        case 0xF0:
            return @"-2";
            break;
            
        case 0xED:
            return @"-7/3";
            break;
            
        case 0xEC:
            return @"-5/2";
            break;
            
        case 0xEB:
            return @"-8/3";
            break;
            
        case 0xE8:
            return @"-3";
            break;
            
        case 0xE5:
            return @"-10/3";
            break;
            
        case 0xE3:
            return @"-11/3";
            break;
            
        case 0xE0:
            return @"-4";
            break;
            
        case 0xDD:
            return @"-13/3";
            break;
            
        case 0xDB:
            return @"-14/3";
            break;
            
        case 0xD8:
            return @"-5";
            break;
            
        default:
            break;
    }
    return nil;
}

//相机模式
+ (NSString *)ModeTitle:(Byte)type
{
    switch (type) {
        case 0x01:
            return @"P";
            break;
            
        case 0x02:
            return @"TV";
            break;
            
        case 0x03:
            return @"AV";
            break;
            
        case 0x04:
            return @"M";
            break;
            
        case 0x05:
            return @"Bulb";
            break;
            
        case 0x06:
            return @"A-DEP";
            break;
            
        case 0x07:
            return @"DEP";
            break;
            
        case 0x08:
            return @"Custom";
            break;
            
        case 0x09:
            return @"Lock";
            break;
            
        case 0x0A:
            return @"Green";
            break;
            
        case 0x0B:
            return @"Ngh";
            break;
            
        case 0x0C:
            return @"Sports";
            break;
            
        case 0x0D:
            return @"Landscape";
            break;
            
        case 0x0E:
            return @"Closeup";
            break;
            
        case 0x0F:
            return @"No Flash";
            break;
            
        default:
            break;
    }
    return nil;
}

//白平衡
+ (NSString *)WhiteBalanceTitle:(Byte)type
{
    switch (type) {
        case 0x00:
            return @"自动";//@"Auto";
            break;
            
        case 0x01:
            return @"日光";//@"Daylight";
            break;
            
        case 0x02:
            return @"阴天";//@"Cloudy";
            break;
            
        case 0x03:
            return @"钨丝灯";//@"Tungsten";
            break;
            
        case 0x04:
            return @"白色荧光灯";//@"Fluorescent";
            break;
            
        case 0x05:
            return @"闪光灯";//@"Strobe";
            break;
            
        case 0x06:
            return @"用户自定义";//@"W/P";
            break;
            
        case 0x07:
            return @"Fluorescent H";
            break;
            
        case 0x08:
            return @"阴影";//@"Shade";
            break;
            
        case 0x09:
            return @"色温";//@"Color Temperature";
            break;
            
        case 0x10:
            return @"Custom Whitebalance PC-1";
            break;
            
        case 0x11:
            return @"Custom Whitebalance PC-2";
            break;
            
        case 0x12:
            return @"Custom Whitebalance PC-3";
            break;
            
        case 0x13:
            return @"Missing Number";
            break;
            
        case 0x14:
            return @"Fluorescent H";
            break;
            
        default:
            break;
    }
    return nil;
}

//Picture Style Title
+ (NSString *)PictureStyleTitle:(Byte)type
{
    switch (type) {
        case 0x21:
            return @"User 1";
            break;
            
        case 0x22:
            return @"User 2";
            break;
            
        case 0x23:
            return @"User 3";
            break;
            
        case 0x81:
            return @"Standard";
            break;
            
        case 0x82:
            return @"Portrait";
            break;
            
        case 0x83:
            return @"Landscape";
            break;
            
        case 0x84:
            return @"Neutral";
            break;
            
        case 0x85:
            return @"Faithful";
            break;
            
        case 0x86:
            return @"Monochrome";
            break;
            
        default:
            break;
    }
    return nil;
}

@end
