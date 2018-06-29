//
//  JYLookupTableMethod.m
//  socketDemo
//
//  Created by 海二少 on 2018/6/29.
//  Copyright © 2018年 海二少. All rights reserved.
//

#import "JYLookupTableMethod.h"
#import "NSArray+LHArray.h"
#import "NSString+LHString.h"
#import "LHSocketOperation.h"
#import "LHSocketResponse.h"
#import "LHSocketProperty.h"
#import "LHConst.h"
@implementation JYLookupTableMethod

+ (void)apertureDefaultSelect:(NSString *)defaultStr andValuesArr:(NSArray *)valuesArr resultBlock:(void (^)(NSInteger selectIndex))resultBlock{
    float value = (float)[NSArray arrayConverIntWithString:defaultStr];
//    NSLog(@"apertureDefaultSelect>>> %f",value);
    __block float tempValue = value/100;
    __block NSInteger selectIndex = 0;
    dispatch_queue_t queue = dispatch_queue_create("socket.apertureDefaultSelect.Queue", DISPATCH_QUEUE_SERIAL);
    dispatch_async(queue, ^{
        for (int i = 0; i<valuesArr.count; i++) {
            NSString *tempStr = valuesArr[i];
            float tempInt = [tempStr floatValue];
//            NSLog(@"apertureDefaultSelect>>>: %f -- %f",tempInt,tempValue);
            if (tempInt == tempValue) {
                selectIndex = i;
                resultBlock(selectIndex);
            }
        }
    });
}

+ (void)shutterDefaultSelect:(NSString *)defaultStr andValuesArr:(NSArray *)valuesArr resultBlock:(void (^)(NSInteger selectIndex))resultBlock{
//    NSLog(@"shutterDefaultSelect>>> %@",defaultStr);
    NSString *str0 = [defaultStr substringWithRange:NSMakeRange(0, 4)];
    NSString *str1 = [defaultStr substringFromIndex:4];
    __block long value = [NSArray arrayConverIntWithArray:@[str0,str1]];
    __block float tempValue = 0;
    __block NSInteger selectIndex = 0;
    dispatch_queue_t queue = dispatch_queue_create("socket.shutterDefaultSelect.Queue", DISPATCH_QUEUE_SERIAL);
    dispatch_async(queue, ^{
        for (int i = 0; i<valuesArr.count; i++) {
            NSString *tempStr = valuesArr[i];
            if ([tempStr containsString:@"/"]) {
                tempValue = [[tempStr componentsSeparatedByString:@"/"].lastObject floatValue];
                tempValue = 10000/tempValue;
            }else{
                tempValue = [tempStr floatValue];
                tempValue = tempValue*10000;
            }
            if ((int)tempValue == value) {
                selectIndex = i;
                resultBlock(selectIndex);
            }
        }
    });
}

+ (void)exposureCompensationDefaultSelect:(NSString *)defaultStr andValuesArr:(NSArray *)valuesArr resultBlock:(void (^)(NSInteger selectIndex))resultBlock{
    long value = [NSArray arrayConverIntWithString:defaultStr];
    float valueFloat = 0;
    if (value > 32768) {
        value = value - 65536;
    }
    valueFloat = [[NSString stringWithFormat:@"%0.1f",(float)value/1000] floatValue];
    __block float tempValue = 0;
    __block NSInteger selectIndex = 0;
    dispatch_queue_t queue = dispatch_queue_create("socket.exposureCompensationDefaultSelect.Queue", DISPATCH_QUEUE_SERIAL);
    dispatch_async(queue, ^{
        for (int i = 0 ; i<valuesArr.count; i++) {
            NSString *tempStr = valuesArr[i];
            tempValue = [tempStr floatValue];
            if (valueFloat == tempValue) {
                selectIndex = i;
                resultBlock(selectIndex);
            }
        }
    });
}

+ (void)ISODefaultSelect:(NSString *)defaultStr andValuesArr:(NSArray *)valuesArr resultBlock:(void (^)(NSInteger selectIndex))resultBlock{
    __block long value = [NSArray arrayConverIntWithString:defaultStr];
    __block long tempValue = 0;
    __block NSInteger selectIndex = 0;
    dispatch_queue_t queue = dispatch_queue_create("socket.ISODefaultSelect.Queue", DISPATCH_QUEUE_SERIAL);
    dispatch_async(queue, ^{
        for (int i = 0 ; i<valuesArr.count; i++) {
            NSString *tempStr = valuesArr[i];
            tempValue = [tempStr longLongValue];
            if (value == tempValue) {
                selectIndex = i;
            }
        }
        resultBlock(selectIndex);
    });
}

+ (NSInteger)whiteBalanceDefaultSelect:(NSString *)defaultStr{
    NSInteger selectIndex = 0;
    if ([defaultStr compareWithHexint:NikonWhitebalance_Auto]) {
        selectIndex = 0;
    }else if ([defaultStr compareWithHexint:NikonWhitebalance_Sunny]){
        selectIndex = 1;
    }else if ([defaultStr compareWithHexint:NikonWhitebalance_Fluorescent]){
        selectIndex = 2;
    }else if ([defaultStr compareWithHexint:NikonWhitebalance_Incandescent]){
        selectIndex = 3;
    }else if ([defaultStr compareWithHexint:NikonWhitebalance_Flash]){
        selectIndex = 4;
    }else if ([defaultStr compareWithHexint:NikonWhitebalance_Cloudy]){
        selectIndex = 5;
    }else if ([defaultStr compareWithHexint:NikonWhitebalance_SunnyShade]){
        selectIndex = 6;
    }else if ([defaultStr compareWithHexint:NikonWhitebalance_ColorTemperature]){
        selectIndex = 7;
    }else if ([defaultStr compareWithHexint:NikonWhitebalance_Preset]){
        selectIndex = 8;
    }else{
        selectIndex = 0;
    }
    return selectIndex;
}

+ (NSInteger)afModelDefaultSelect:(NSString *)defaultStr {
    
    if ([defaultStr compareNotConverHexint:NikonFocusModelGetValue_AF_S]) {
        return 0;
    }else if ([defaultStr compareNotConverHexint:NikonFocusModelGetValue_AF_C]){
        return 1;
    }else if ([defaultStr compareNotConverHexint:NikonFocusModelGetValue_AF_A]){
        return 2;
    }else if ([defaultStr compareNotConverHexint:NikonFocusModelGetValue_MF]){
        return 3;
    }else{
        return 0;
    }
    
}

+ (NSInteger)cameraModelDefaultSelect:(NSString *)defaultStr {
    
    if ([defaultStr compareWithHexint:ExposureProgramModel_m]) {
        return 0;
    }else if ([defaultStr compareWithHexint:ExposureProgramModel_program]){
        return 1;
    }else if ([defaultStr compareWithHexint:ExposureProgramModel_av]){
        return 2;
    }else if ([defaultStr compareWithHexint:ExposureProgramModel_tv]){
        return 3;
    }else if ([defaultStr compareWithHexint:ExposureProgramModel_auto]){
        return 4;
    }else if ([defaultStr compareWithHexint:ExposureProgramModel_portrait]){
        return 5;
    }else if ([defaultStr compareWithHexint:ExposureProgramModel_landscape]){
        return 6;
    }else if ([defaultStr compareWithHexint:ExposureProgramModel_close_up]){
        return 7;
    }else if ([defaultStr compareWithHexint:ExposureProgramModel_sports]){
        return 8;
    }else if ([defaultStr compareWithHexint:ExposureProgramModel_night_scene_portrait]){
        return 9;
    }else if ([defaultStr compareWithHexint:ExposureProgramModel_flash_off]){
        return 10;
    }else if ([defaultStr compareWithHexint:ExposureProgramModel_Child]){
        return 11;
    }else if ([defaultStr compareWithHexint:ExposureProgramModel_SCENE]){
        return 12;
    }else if ([defaultStr compareWithHexint:ExposureProgramModel_mode_U1]){
        return 13;
    }else if ([defaultStr compareWithHexint:ExposureProgramModel_mode_U2]){
        return 14;
    }else if ([defaultStr compareWithHexint:ExposureProgramModel_SCENE]){
        return 15;
    }else{
        return 0;
    }
}


/*@[@"bulb", @"30", @"25", @"20", @"15", @"13", @"10", @"8", @"6", @"5", @"4", @"3", @"2.5", @"2", @"1.6", @"1.3", @"1", @"1/1.3", @"1/1.6", @"1/2", @"1/2.5", @"1/3", @"1/4", @"1/5", @"1/6", @"1/8", @"1/10", @"1/13", @"1/15", @"1/20", @"1/25", @"1/30", @"1/40", @"1/50", @"1/60", @"1/80", @"1/100", @"1/125", @"1/160", @"1/200", @"1/250", @"1/320", @"1/400", @"1/500", @"1/640", @"1/800", @"1/1000", @"1/1250", @"1/1600", @"1/2000", @"1/2500", @"1/3200", @"1/4000"];*/
/*const ValueTitle<VT_SHSPEED, VT_SHSPEED_TEXT_LEN> ShutterSpeedTitles[] PROGMEM =
{
    {0x00000002,    {'4','0','0','0',0} },
    {0x00000003,    {'3','2','0','0',0} },
    {0x00000004,    {'2','5','0','0',0} },
    {0x00000005,    {'2','0','0','0',0} },
    {0x00000006,    {'1','6','0','0',0} },
    {0x00000008,    {'1','2','5','0',0} },
    {0x0000000A,    {'1','0','0','0',0} },
    {0x0000000C,    {' ','8','0','0',0} },
    {0x0000000F,    {' ','6','4','0',0} },
    {0x00000014,    {' ','5','0','0',0} },
    {0x00000019,    {' ','4','0','0',0} },
    {0x0000001F,    {' ','3','2','0',0} },
    {0x00000028,    {' ','2','5','0',0} },
    {0x00000032,    {' ','2','0','0',0} },
    {0x0000003E,    {' ','1','6','0',0} },
    {0x00000050,    {' ','1','2','5',0} },
    {0x00000064,    {' ','1','0','0',0} },
    {0x0000007D,    {' ',' ','8','0',0} },
    {0x000000A6,    {' ',' ','6','0',0} },
    {0x000000C8,    {' ',' ','5','0',0} },
    {0x000000FA,    {' ',' ','4','0',0} },
    {0x0000014D,    {' ',' ','3','0',0} },
    {0x00000190,    {' ',' ','2','5',0} },
    {0x000001F4,    {' ',' ','2','0',0} },
    {0x0000029A,    {' ',' ','1','5',0} },
    {0x00000301,    {' ',' ','1','3',0} },
    {0x000003E8,    {' ',' ','1','0',0} },
    {0x000004E2,    {' ',' ',' ','8',0} },
    {0x00000682,    {' ',' ',' ','6',0} },
    {0x000007D0,    {' ',' ',' ','5',0} },
    {0x000009C4,    {' ',' ',' ','4',0} },
    {0x00000D05,    {' ',' ',' ','3',0} },
    {0x00000FA0,    {' ','2','.','5',0} },
    {0x00001388,    {' ',' ',' ','2',0} },
    {0x0000186A,    {' ','1','.','6',0} },
    {0x00001E0C,    {' ','1','.','3',0} },
    {0x00002710,    {' ',' ','1','"',0} },
    {0x000032C8,    {'1','.','3','"',0} },
    {0x00003E80,    {'1','.','6','"',0} },
    {0x00004E20,    {' ',' ','2','"',0} },
    {0x000061A8,    {'2','.','5','"',0} },
    {0x00007530,    {' ',' ','3','"',0} },
    {0x00009C40,    {' ',' ','4','"',0} },
    {0x0000C350,    {' ',' ','5','"',0} },
    {0x0000EA60,    {' ',' ','6','"',0} },
    {0x00013880,    {' ',' ','8','"',0} },
    {0x000186A0,    {' ','1','0','"',0} },
    {0x0001FBD0,    {' ','1','3','"',0} },
    {0x000249F0,    {' ','1','5','"',0} },
    {0x00030D40,    {' ','2','0','"',0} },
    {0x0003D090,    {' ','2','5','"',0} },
    {0x000493E0,    {' ','3','0','"',0} },
    {0xFFFFFFFF,    {'B','u','l','B',0} }
};
*/
+ (NSString *)lockupShutterSpeedForValue:(int)value{
    NSDictionary *shutterSpeedDict = @{@"1/4000":@(0x00000002),
                                       @"1/3200":@(0x00000003),
                                       @"1/2500":@(0x00000004),
                                       @"1/2000":@(0x00000005),
                                       @"1/1600":@(0x00000006),
                                       @"1/1250":@(0x00000008),
                                       @"1/1000":@(0x0000000A),
                                       @"1/800":@(0x0000000C),
                                       @"1/640":@(0x0000000F),
                                       @"1/500":@(0x00000014),
                                       @"1/400":@(0x00000019),
                                       @"1/320":@(0x0000001F),
                                       @"1/250":@(0x00000028),
                                       @"1/200":@(0x00000032),
                                       @"1/160":@(0x0000003E),
                                       @"1/125":@(0x00000050),
                                       @"1/100":@(0x00000064),
                                       @"1/80":@(0x0000007D),
                                       @"1/60":@(0x000000A6),
                                       @"1/50":@(0x000000C8),
                                       @"1/40":@(0x000000FA),
                                       @"1/30":@(0x0000014D),
                                       @"1/25":@(0x00000190),
                                       @"1/20":@(0x000001F4),
                                       @"1/15":@(0x0000029A),
                                       @"1/13":@(0x00000301),
                                       @"1/10":@(0x000003E8),
                                       @"1/8":@(0x000004E2),
                                       @"1/6":@(0x00000682),
                                       @"1/5":@(0x000007D0),
                                       @"1/4":@(0x000009C4),
                                       @"1/3":@(0x00000D05),
                                       @"1/2.5":@(0x00000FA0),
                                       @"1/2":@(0x00001388),
                                       @"1/1.6":@(0x0000186A),
                                       @"1/1.3":@(0x00001E0C),
                                       @"1":@(0x00002710),
                                       @"1.3":@(0x000032C8),
                                       @"1.6":@(0x00003E80),
                                       @"2":@(0x00004E20),
                                       @"2.5":@(0x000061A8),
                                       @"3":@(0x00007530),
                                       @"4":@(0x00009C40),
                                       @"5":@(0x0000C350),
                                       @"6":@(0x0000EA60),
                                       @"8":@(0x00013880),
                                       @"10":@(0x000186A0),
                                       @"13":@(0x0001FBD0),
                                       @"15":@(0x000249F0),
                                       @"20":@(0x00030D40),
                                       @"25":@(0x0003D090),
                                       @"30":@(0x000493E0),
                                       @"bulb":@(0xFFFFFFFF)
                                       };
    __block NSString *objectId;
    [shutterSpeedDict enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        NSLog(@"key = %@ and obj = %@", key, obj);
        if ((int)obj == value) {
            objectId = key;
            NSLog(@"----------%@",objectId);
        }
        
    }];
    return objectId;
    
}
@end
