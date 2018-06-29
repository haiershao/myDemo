

#import "JYNikon.h"
#import <UIKit/UIKit.h>
@implementation JYNikon

//型号
+ (NSArray *)nikonModelSetting
{
    NSMutableArray *models = [NSMutableArray array];
    NSArray *title_v = @[@"D7200", @"D5300"];
    
    Byte set_v[title_v.count];
    for (int i = 0; i < title_v.count; i++) {
        set_v[i] = (Byte) (30 + i) & 0xFF;
    }
    
    for (int i = 0; i < title_v.count; i++) {
        JYNikon *nikon_model = [[JYNikon alloc] init];
        nikon_model._values = title_v[i];
        nikon_model._value_send = set_v[i];
        [models addObject:nikon_model];
    }
    
    return [models copy];
}

//光圈
+ (NSArray *)nikonApertureWithModel
{
    return @[@"4.5", @"5.0", @"5.6", @"6.3", @"7.1", @"8.0", @"9.0", @"10", @"11", @"13", @"14", @"16", @"18", @"20", @"22",@"25",@"29"];
//    NSArray *title_v;
//    switch (model) {
//        case Camera_Model_Nikon_D7200:
//        {///*3.5  4.0  4.5  5.0  5.6  6.3  7.1  8.0  9.0  10  11  13    14    16    18    20    22*/
//            title_v = @[@"3.5", @"4.0", @"4.5", @"5.0", @"5.6", @"6.3", @"7.1", @"8.0", @"9.0", @"10", @"11", @"13", @"14", @"16", @"18", @"20", @"22"];
//        }
//            break;
//
//        case Camera_Model_Nikon_D5300:
//        {
//            title_v = @[@"4.2", @"4.5", @"5.0", @"5.6", @"6.3", @"7.1", @"8.0", @"9.0", @"10", @"11", @"13", @"14", @"16", @"18", @"20", @"22", @"25", @"29"];
//        }
//            break;
//
//        default:
//            break;
//    }
//
//    return [self assemblyDataWithParameter:title_v];
}
//快门
+ (NSArray *)nikonShutterSpeedWithModel
{
    return @[@"bulb", @"30", @"25", @"20", @"15", @"13", @"10", @"8", @"6", @"5", @"4", @"3", @"2.5", @"2", @"1.6", @"1.3", @"1", @"1/1.3", @"1/1.6", @"1/2", @"1/2.5", @"1/3", @"1/4", @"1/5", @"1/6", @"1/8", @"1/10", @"1/13", @"1/15", @"1/20", @"1/25", @"1/30", @"1/40", @"1/50", @"1/60", @"1/80", @"1/100", @"1/125", @"1/160", @"1/200", @"1/250", @"1/320", @"1/400", @"1/500", @"1/640", @"1/800", @"1/1000", @"1/1250", @"1/1600", @"1/2000", @"1/2500", @"1/3200", @"1/4000"];
//    //52
//    NSArray *title_v;
//    switch (model) {
//        case Camera_Model_Nikon_D7200:
//        {
//            /*bulb    30    25    20    15    13    10    8    6    5    4    3     2.5    2   1.6        1.3        1  1/1.3     1/1.6    1/2        1/2.5    1/3        1/4        1/5        1/6        1/8        1/10    1/13    1/15 1/20 1/25    1/30    1/40    1/50    1/60    1/80    1/100    1/125    1/160    1/200    1/250    1/320    1/400
//             1/500    1/640    1/800    1/1000    1/1250    1/1600    1/2000    1/2500    1/3200    1/4000  1/8000 */
//            title_v = @[@"bulb", @"30", @"25", @"20", @"15", @"13", @"10", @"8", @"6", @"5", @"4", @"3", @"2.5", @"2", @"1.6", @"1.3", @"1", @"1/1.3", @"1/1.6", @"1/2", @"1/2.5", @"1/3", @"1/4", @"1/5", @"1/6", @"1/8", @"1/10", @"1/13", @"1/15", @"1/20", @"1/25", @"1/30", @"1/40", @"1/50", @"1/60", @"1/80", @"1/100", @"1/125", @"1/160", @"1/200", @"1/250", @"1/320", @"1/400", @"1/500", @"1/640", @"1/800", @"1/1000", @"1/1250", @"1/1600", @"1/2000", @"1/2500", @"1/3200", @"1/4000", @"1/8000"];
//        }
//            break;
//
//        case Camera_Model_Nikon_D5300:
//        {
//            /*bulb    30    25    20    15    13    10    8    6    5    4    3     2.5    2   1.6        1.3        1
//             1/1.3     1/1.6    1/2        1/2.5    1/3        1/4        1/5        1/6        1/8        1/10    1/13    1/15    1/20
//             1/25    1/30    1/40    1/50    1/60    1/80    1/100    1/125    1/160    1/200    1/250    1/320    1/400
//             1/500    1/640    1/800    1/1000    1/1250    1/1600    1/2000    1/2500    1/3200    1/4000*/
//            title_v = @[@"bulb", @"30", @"25", @"20", @"15", @"13", @"10", @"8", @"6", @"5", @"4", @"3", @"2.5", @"2", @"1.6", @"1.3", @"1", @"1/1.3", @"1/1.6", @"1/2", @"1/2.5", @"1/3", @"1/4", @"1/5", @"1/6", @"1/8", @"1/10", @"1/13", @"1/15", @"1/20", @"1/25", @"1/30", @"1/40", @"1/50", @"1/60", @"1/80", @"1/100", @"1/125", @"1/160", @"1/200", @"1/250", @"1/320", @"1/400", @"1/500", @"1/640", @"1/800", @"1/1000", @"1/1250", @"1/1600", @"1/2000", @"1/2500", @"1/3200", @"1/4000"];
//        }
//            break;
//
//        default:
//            break;
//    }
//
//    return [self assemblyDataWithParameter:title_v];
}
//ISO
+ (NSArray *)nikonISOWithModel
{
    return @[@"100", @"125", @"160", @"200", @"250", @"320", @"400", @"500", @"640", @"800", @"1000", @"1250", @"1600", @"2000", @"2500", @"3200", @"4000", @"5000", @"6400"];
//    NSArray *title_v;
//    switch (model) {
//        case Camera_Model_Nikon_D7200:
//        {/*{0,100,125,160,200,250,320,400,500,640,800,1000,1250,1600,2000,2500,3200,4000,5000,6400,8000,10000,12800,16000,20000,25600}*/
//            title_v = @[@"0", @"100", @"125", @"160", @"200", @"250", @"320", @"400", @"500", @"640", @"800", @"1000", @"1250", @"1600", @"2000", @"2500", @"3200", @"4000", @"5000", @"6400", @"8000", @"10000", @"12800", @"16000", @"20000", @"25600"];
//        }
//            break;
//
//        case Camera_Model_Nikon_D5300:
//        {/*{0,100,125,160,200,250,320,400,500,640,800,1000,1250,1600,2000,2500,3200,4000,5000,6400,8000,10000,12800,20000}*/
//            title_v = @[@"0", @"100", @"125", @"160", @"200", @"250", @"320", @"400", @"500", @"640", @"800", @"1000", @"1250", @"1600", @"2000", @"2500", @"3200", @"4000", @"5000", @"6400", @"8000", @"10000", @"12800", @"20000"];
//        }
//            break;
//
//        default:
//            break;
//    }
//
//    return [self assemblyDataWithParameter:title_v];
}
//曝光补偿
+ (NSArray *)nikonCompensationWithModel
{
    return @[@"-5",@"-4.7",@"-4.3",@"-4.0",@"-3.7",@"-3.3",@"-3.0",@"-2.7",@"-2.3",@"-2.0",@"-1.7",@"-1.3",@"-1.0",@"-0.7",@"-0.3",@"0.0",@"0.3",@"0.7",@"1.0",@"1.3",@"1.7",@"2.0",@"2.3",@"2.7",@"3.0",@"3.3",@"3.7",@"4.0",@"4.3",@"4.7",@"5"];
//    /*-5  .  .  4  .  .  3  .  .  2  .  .  1  .  . 0  .  .  1  .  .  2  .  .  3  .  .  4  .  .  5*/
//    NSMutableArray *title_v = [NSMutableArray array];
//    switch (model) {
//        case Camera_Model_Nikon_D7200:
//        case Camera_Model_Nikon_D5300:
//        {
//            NSString *v = nil;
//            for (int i = 0; i < 31; i++) {
//                if (0 == i%3) {
//                    v = [NSString stringWithFormat:@"%.0f", (CGFloat)(-5 + i/3)];
//                } else {
//                    v = [NSString stringWithFormat:@"%0.f/3", (CGFloat)(-5*3 + i)];
//                }
//                [title_v addObject:v];
//            }
//        }
//            break;
//
//        default:
//            break;
//    }
//
//    return [self assemblyDataWithParameter:title_v];
}
//焦距
+ (NSArray *)nikonImageZoomWithModel:(Camera_Model)model
{
    /* x1   x1.25   x1.33  x1.5  x1.67  x2  x4*/
    NSArray *title_v;
    switch (model) {
        case Camera_Model_Nikon_D7200:
        case Camera_Model_Nikon_D5300:
        {
           title_v = @[@"x1", @"x1.25", @"x1.33", @"x1.5", @"x1.67", @"x2", @"x4"];
        }
            break;
            
        default:
            break;
    }
    
    return [self assemblyDataWithParameter:title_v];
}

////对焦变远
//+ (NSArray *)nikonFoucsFarWithModel:(Camera_Model)model;
////对焦变近
//+ (NSArray *)nikonFoucsNearWithModel:(Camera_Model)model;

/*
 nikonExposureProgramMap.put(0x0001, R.drawable.shootingmode_m);
 nikonExposureProgramMap.put(0x0002, R.drawable.shootingmode_program);
 nikonExposureProgramMap.put(0x0003, R.drawable.shootingmode_av);
 nikonExposureProgramMap.put(0x0004, R.drawable.shootingmode_tv);
 nikonExposureProgramMap.put(0x8010, R.drawable.shootingmode_auto);
 nikonExposureProgramMap.put(0x8011, R.drawable.shootingmode_portrait);
 nikonExposureProgramMap.put(0x8012, R.drawable.shootingmode_landscape);
 nikonExposureProgramMap.put(0x8013, R.drawable.shootingmode_close_up);
 nikonExposureProgramMap.put(0x8014, R.drawable.shootingmode_sports);
 nikonExposureProgramMap.put(0x8015, R.drawable.shootingmode_night_scene_portrait);
 nikonExposureProgramMap.put(0x8016, R.drawable.shootingmode_flash_off);
 nikonExposureProgramMap.put(0x8017, R.drawable.shootingmode_unknown); // TODO Child
 nikonExposureProgramMap.put(0x8018, R.drawable.shootingmode_unknown); // TODO SCENE
 nikonExposureProgramMap.put(0x8050, R.drawable.shootingmode_unknown); // TODO User mode U1
 nikonExposureProgramMap.put(0x8051, R.drawable.shootingmode_unknown); // TODO User mode U2
 */
//相机拍摄模式
+ (NSArray *)nikonVideoModeWithModel:(Camera_Model)model
{
    /*capture,   advanced capture,  video*/
    NSArray *title_v;
    switch (model) {
        case Camera_Model_Nikon_D7200:
        case Camera_Model_Nikon_D5300:
        {
            title_v = @[@"capture", @"advanced capture", @"video"];
        }
            break;
            
        default:
            break;
    }
    
    return [self assemblyDataWithParameter:title_v];
}

+ (NSArray *)nikonExposureProgramModel
{
    return @[@"m",@"program",@"av",@"tv",@"auto",@"portrait",@"landscape",@"close_up",@"sports",@"night_scene_portrait",@"flash_off",@"Child",@"SCENE",@"mode U1",@"mode U2"];
}

+ (NSArray *)nikonAFModel
{
    return @[@"AF-S",@"AF-C",@"AF-A",@"MF"];
}

//白平衡
+ (NSArray *)nikonWhiteBalanceWithModel
{
    
    return @[@"auto", @"sun", @"Fluorescent", @"Incandescent", @"Flash", @"Cloudy", @"Sunny shade",@"Color temperature",@"Preset"];
//    /*auto sun ying-light baizhi-light flash cloudy  shadow */
//    NSArray *title_v;
//    switch (model) {
//        case Camera_Model_Nikon_D7200:
//        case Camera_Model_Nikon_D5300:
//        {
//            title_v = @[@"auto", @"sun", @"ying-light", @"baizhi-light", @"flash", @"cloudy", @"shadow"];
//        }
//            break;
//
//        default:
//            break;
//    }
//
//    return [self assemblyDataWithParameter:title_v];
}
////录像模式开关
//+ (NSArray *)nikonVideoPowerSwitchWithModel:(Camera_Model)model;

//USB连接开关
+ (NSArray *)nikonUSBConnectSwitchWithModel:(Camera_Model)model
{
    NSArray *title_v;
    switch (model) {
        case Camera_Model_Nikon_D7200:
        case Camera_Model_Nikon_D5300:
        {
            title_v = @[@"off", @"on"];
        }
            break;
            
        default:
            break;
    }
    
    return [self assemblyDataWithParameter:title_v];
}

@end
