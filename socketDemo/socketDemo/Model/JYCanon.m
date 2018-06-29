

#import "JYCanon.h"
#import <UIKit/UIKit.h>
@implementation JYCanon

//型号
+ (NSArray *)canonModelSetting
{
    NSMutableArray *models = [NSMutableArray array];
    NSArray *title_v = @[@"700D", @"5D3", @"5D2", @"6D", @"80D", @"5D4", @"6D2", @"500D", @"Other"];
    
    Byte set_v[title_v.count];
    for (int i = 0; i < title_v.count; i++) {
        set_v[i] = (Byte) (10  + i) & 0xFF;
    }
    
    for (int i = 0; i < title_v.count; i++) {
        JYCanon *canon_model = [[JYCanon alloc] init];
        canon_model._values = title_v[i];
        canon_model._value_send = set_v[i];
        [models addObject:canon_model];
    }
    
    return [models copy];
}

//光圈
+ (NSArray *)canonApertureWithModel:(Camera_Model)model
{
    NSArray *title_v;
    switch (model) {
        case Camera_Model_Canon_700D:
        case Camera_Model_Canon_80D:
        {/*4.5        5.0        5.6        6.3        7.1        8.0        9.0        10    11    13    14    16    18    20    22 25 29*/
            title_v = @[@"4.5", @"5.0", @"5.6", @"6.3", @"7.1", @"8.0", @"9.0", @"10", @"11", @"13", @"14", @"16", @"18", @"20", @"22", @"25", @"29"];
        }
            break;
            
        case Camera_Model_Canon_5D2:
        case Camera_Model_Canon_5D3:
        case Camera_Model_Canon_6D:
        case Camera_Model_Canon_6D2:
        case Camera_Model_Canon_500D:
        {/*3.5  4.0  4.5        5.0        5.6        6.3        7.1        8.0        9.0        10    11    13    14    16    18    20    22*/
            title_v = @[@"3.5", @"4.0", @"4.5", @"5.0", @"5.6", @"6.3", @"7.1", @"8.0", @"9.0", @"10", @"11", @"13", @"14", @"16", @"18", @"20", @"22"];
        }
            break;
            
        case Camera_Model_Canon_5D4:
        {/*2.8  3.2   3.5    4.0        4.5        5.0        5.6        6.3        7.1        8.0        9.0        10    11    13    14    16    18    20    22*/
            title_v = @[@"2.8", @"3.2", @"3.5", @"4.0", @"4.5", @"5.0", @"5.6", @"6.3", @"7.1", @"8.0", @"9.0", @"10", @"11", @"13", @"14", @"16", @"18", @"20", @"22"];
        }
            break;
            
        default:
            break;
    }
    
    return [self assemblyDataWithParameter:title_v];
}

//快门
+ (NSArray *)canonShutterSpeedWithModel:(Camera_Model)model
{
    NSArray *title_v;
    switch (model) {
        case Camera_Model_Canon_700D:
        case Camera_Model_Canon_500D:
        {/*bulb    30    25    20    15    13    10    8    6    5    4    3.2     2.5    2   1.6        1.3        1
          0.8    0.6        0.5        0.4        0.3        1/4        1/5        1/6        1/8        1/10    1/13    1/15    1/20
          1/25    1/30    1/40    1/50    1/60    1/80    1/100    1/125    1/160    1/200    1/250    1/320    1/400
          1/500    1/640    1/800    1/1000    1/1250    1/1600    1/2000    1/2500    1/3200    1/4000*/
            title_v = @[@"30", @"25", @"20", @"15", @"13", @"10", @"8", @"6", @"5", @"4", @"3.2", @"2.5", @"2", @"1.6", @"1.3", @"1", @"0.8", @"0.6", @"0.5", @"0.4", @"0.3", @"1/4", @"1/5", @"1/6", @"1/8", @"1/10", @"1/13", @"1/15", @"1/20", @"1/25", @"1/30", @"1/40", @"1/50", @"1/60", @"1/80", @"1/100", @"1/125", @"1/160", @"1/200", @"1/250", @"1/320", @"1/400", @"1/500", @"1/640", @"1/800", @"1/1000", @"1/1250", @"1/1600", @"1/2000", @"1/2500", @"1/3200", @"1/4000"];
        }
            break;
            
        case Camera_Model_Canon_6D:
        case Camera_Model_Canon_6D2:
        {
            title_v = @[@"30", @"25", @"20", @"15", @"13", @"10", @"8", @"6", @"5", @"4", @"3.2", @"2.5", @"2", @"1.6", @"1.3", @"1", @"0.8", @"0.6", @"0.5", @"0.4", @"0.3", @"1/4", @"1/5", @"1/6", @"1/8", @"1/10", @"1/13", @"1/15", @"1/20", @"1/25", @"1/30", @"1/40", @"1/50", @"1/60", @"1/80", @"1/100", @"1/125", @"1/160", @"1/200", @"1/250", @"1/320", @"1/400", @"1/500", @"1/640", @"1/800", @"1/1000", @"1/1250", @"1/1600", @"1/2000", @"1/2500", @"1/3200", @"1/4000"];
        }
            break;
          
        case Camera_Model_Canon_5D2:
        case Camera_Model_Canon_5D3:
        case Camera_Model_Canon_80D:
        case Camera_Model_Canon_5D4:
        {/*bulb    30    25    20    15    13    10    8    6    5    4    3.2     2.5    2   1.6        1.3        1
          0.8    0.6        0.5        0.4        0.3        1/4        1/5        1/6        1/8        1/10    1/13    1/15    1/20
          1/25    1/30    1/40    1/50    1/60    1/80    1/100    1/125    1/160    1/200    1/250    1/320    1/400
          1/500    1/640    1/800    1/1000    1/1250    1/1600    1/2000    1/2500    1/3200    1/4000  1/5000  1/6400  1/8000*/
            title_v = @[@"30", @"25", @"20", @"15", @"13", @"10", @"8", @"6", @"5", @"4", @"3.2", @"2.5", @"2", @"1.6", @"1.3", @"1", @"0.8", @"0.6", @"0.5", @"0.4", @"0.3", @"1/4", @"1/5", @"1/6", @"1/8", @"1/10", @"1/13", @"1/15", @"1/20", @"1/25", @"1/30", @"1/40", @"1/50", @"1/60", @"1/80", @"1/100", @"1/125", @"1/160", @"1/200", @"1/250", @"1/320", @"1/400", @"1/500", @"1/640", @"1/800", @"1/1000", @"1/1250", @"1/1600", @"1/2000", @"1/2500", @"1/3200", @"1/4000", @"1/5000", @"1/6400", @"1/8000"];
        }
            break;
            
        default:
            break;
    }
    
    return [self assemblyDataWithParameter:title_v];
}

//ISO
+ (NSArray *)canonISOWithModel:(Camera_Model)model
{
    NSArray *title_v;
    switch (model) {
        case Camera_Model_Canon_700D:
        {/*Auto 100    200    400    800    1600 3200 6400 12800*/
            title_v = @[@"Auto", @"100", @"200", @"400", @"800", @"1600", @"3200", @"6400", @"12800"];
        }
            break;
            
        case Camera_Model_Canon_5D2:
        {/*Auto 100 125    160  200  250  320    400    500  640  800    1000 1250 1600 2000 2500 3200 4000 5000 6400*/
            title_v = @[@"Auto", @"100", @"125", @"160", @"200", @"250", @"320", @"400", @"500", @"640", @"800", @"1000", @"1250", @"1600", @"2000", @"2500", @"3200", @"4000", @"5000", @"6400"];
        }
            break;
            
        case Camera_Model_Canon_5D3:
        case Camera_Model_Canon_6D:
        {/*Auto 100 125    160  200  250  320    400    500  640  800    1000 1250 1600 2000 2500 3200 4000 5000 6400 8000 10000 12800 16000 20000 25600*/
            title_v = @[@"Auto", @"100", @"125", @"160", @"200", @"250", @"320", @"400", @"500", @"640", @"800", @"1000", @"1250", @"1600", @"2000", @"2500", @"3200", @"4000", @"5000", @"6400", @"8000", @"10000", @"12800", @"16000", @"20000", @"25600"];
        }
            break;
            
        case Camera_Model_Canon_80D:
        {/*Auto 100 125    160  200  250  320    400    500  640  800    1000 1250 1600 2000 2500 3200 4000 5000 6400 8000 10000 12800 16000*/
            title_v = @[@"Auto", @"100", @"125", @"160", @"200", @"250", @"320", @"400", @"500", @"640", @"800", @"1000", @"1250", @"1600", @"2000", @"2500", @"3200", @"4000", @"5000", @"6400", @"8000", @"10000", @"12800", @"16000"];
        }
            break;
            
        case Camera_Model_Canon_5D4:
        {/*Auto 100 125 160 200 250 320 400 500 640 800 1000 1250 1600 2000 2500 3200 4000 5000 6400  8000  10000  12800  16000  20000  25600  32000*/
            title_v = @[@"Auto", @"100", @"125", @"160", @"200", @"250", @"320", @"400", @"500", @"640", @"800", @"1000", @"1250", @"1600", @"2000", @"2500", @"3200", @"4000", @"5000", @"6400", @"8000", @"10000", @"12800", @"16000", @"20000", @"25600", @"32000"];
        }
            break;
            
        case Camera_Model_Canon_6D2:
        {/*Auto 100 125 160 200 250 320 400 500 640 800 1000 1250 1600 2000 2500 3200 4000 5000 6400  8000 10000 12800 16000 20000  25600  32000  40000*/
            title_v = @[@"Auto", @"100", @"125", @"160", @"200", @"250", @"320", @"400", @"500", @"640", @"800", @"1000", @"1250", @"1600", @"2000", @"2500", @"3200", @"4000", @"5000", @"6400", @"8000", @"10000", @"12800", @"16000", @"20000", @"25600", @"32000", @"40000"];
        }
            break;
            
        case Camera_Model_Canon_500D:
        {/*Auto     200    400    800    1600 3200 */
            title_v = @[@"Auto", @"200", @"400", @"800", @"1600", @"3200"];
        }
            break;
            
        default:
            break;
    }
    
    return [self assemblyDataWithParameter:title_v];
}

//曝光补偿
+ (NSArray *)canonCompensationWithModel:(Camera_Model)model
{
    NSMutableArray *title_v = [NSMutableArray array];
    switch (model) {
        case Camera_Model_Canon_700D:
        case Camera_Model_Canon_6D:
        case Camera_Model_Canon_5D3:
        case Camera_Model_Canon_80D:
        case Camera_Model_Canon_5D4:
        case Camera_Model_Canon_6D2:
        {/*-5  .  .  4  .  .  3  .  .  2  .  .  1  .  . 0  .  .  1  .  .  2  .  .  3  .  .  4  .  .  5*/
            NSString *v = nil;
            for (int i = 0; i < 31; i++) {
                if (0 == i%3) {
                    v = [NSString stringWithFormat:@"%.0f", (CGFloat)(-5 + i/3)];
                } else {
                    v = [NSString stringWithFormat:@"%0.f/3", (CGFloat)(-5*3 + i)];
                }
                [title_v addObject:v];
            }
        }
            break;
            
        case Camera_Model_Canon_5D2:
        case Camera_Model_Canon_500D:
        {
            NSString *v = nil;
            for (int i = 0; i < 13; i++) {
                if (0 == i%3) {
                    v = [NSString stringWithFormat:@"%.0f", (CGFloat)(-2 + i/3)];
                } else {
                    v = [NSString stringWithFormat:@"%0.f/3", (CGFloat)(-2*3 + i)];
                }
                [title_v addObject:v];
            }
        }
            break;
            
        default:
            break;
    }
    
    return [self assemblyDataWithParameter:title_v];
}

//焦距
+ (NSArray *)canonImageZoomWithModel:(Camera_Model)model
{
    NSArray *title_v;
    switch (model) {
        case Camera_Model_Canon_700D:
        case Camera_Model_Canon_5D3:
        case Camera_Model_Canon_5D2:
        case Camera_Model_Canon_6D:
        case Camera_Model_Canon_80D:
        case Camera_Model_Canon_5D4:
        case Camera_Model_Canon_6D2:
        case Camera_Model_Canon_500D:
        {
            title_v = @[@"x1", @"x5", @"x10"];
        }
            break;
            
        default:
            break;
    }
    
    return [self assemblyDataWithParameter:title_v];
}

//对焦变远
+ (NSArray *)canonFoucsFarWithModel:(Camera_Model)model
{
    NSArray *title_v;
    switch (model) {
        case Camera_Model_Canon_700D:
        case Camera_Model_Canon_5D3:
        case Camera_Model_Canon_5D2:
        case Camera_Model_Canon_6D:
        case Camera_Model_Canon_80D:
        case Camera_Model_Canon_5D4:
        case Camera_Model_Canon_6D2:
        case Camera_Model_Canon_500D:
        {
            title_v = @[@"micro", @"medium", @"max"];
        }
            break;
            
        default:
            break;
    }
    
    return [self assemblyDataWithParameter:title_v];
}

//对焦变近
+ (NSArray *)canonFoucsNearWithModel:(Camera_Model)model
{
    NSArray *title_v;
    switch (model) {
        case Camera_Model_Canon_700D:
        case Camera_Model_Canon_5D3:
        case Camera_Model_Canon_5D2:
        case Camera_Model_Canon_6D:
        case Camera_Model_Canon_80D:
        case Camera_Model_Canon_5D4:
        case Camera_Model_Canon_6D2:
        case Camera_Model_Canon_500D:
        {
            title_v = @[@"micro", @"medium", @"max"];
        }
            break;
            
        default:
            break;
    }
    
    return [self assemblyDataWithParameter:title_v];
}

//相机拍摄模式
+ (NSArray *)canonVideoModeWithModel:(Camera_Model)model
{
    NSArray *title_v;
    switch (model) {
        case Camera_Model_Canon_700D:
        case Camera_Model_Canon_500D:
//        {
//            title_v = @[@"P", @"TV", @"AV", @"M", @"Video"];
//        }
//            break;
//
        case Camera_Model_Canon_5D3:
        case Camera_Model_Canon_5D2:
        case Camera_Model_Canon_6D:
        case Camera_Model_Canon_80D:
        case Camera_Model_Canon_5D4:
        case Camera_Model_Canon_6D2:
        {
            title_v = @[@"P", @"TV", @"AV", @"M", @"Video", @"bulb"];
        }
            break;
            
        default:
            break;
    }
    
    return [self assemblyDataWithParameter:title_v];
}

//白平衡
+ (NSArray *)canonWhiteBalanceWithModel:(Camera_Model)model
{
    NSArray *title_v;
    switch (model) {
        case Camera_Model_Canon_700D:
        case Camera_Model_Canon_500D:
        {
            title_v = @[@"自动", @"日光", @"阴天", @"钨丝灯", @"白色荧光灯", @"闪光灯", @"用户自定义", @"阴影"];
            //@[@"Auto", @"sun", @"cloudy", @"wu-light", @"ying-light", @"flash", @"manual", @"shadow"];
        }
            break;
            
        case Camera_Model_Canon_5D2:
        case Camera_Model_Canon_5D3:
        case Camera_Model_Canon_5D4:
        case Camera_Model_Canon_6D2:
        case Camera_Model_Canon_6D:
        case Camera_Model_Canon_80D:
        {
            title_v = @[@"自动", @"日光", @"阴天", @"钨丝灯", @"白色荧光灯", @"闪光灯", @"用户自定义", @"阴影", @"色温"];
            //@[@"Auto", @"sun", @"cloudy", @"wu-light", @"ying-light", @"flash", @"manual", @"shadow", @"color-tempreture"];
        }
            break;
            
        default:
            break;
    }
    
    return [self assemblyDataWithParameter:title_v];
}

//录像模式开关
+ (NSArray *)canonVideoPowerSwitchWithModel:(Camera_Model)model
{
    NSArray *title_v;
    switch (model) {
        case Camera_Model_Canon_700D:
        case Camera_Model_Canon_5D3:
        case Camera_Model_Canon_5D2:
        case Camera_Model_Canon_6D:
        case Camera_Model_Canon_80D:
        case Camera_Model_Canon_5D4:
        case Camera_Model_Canon_6D2:
        case Camera_Model_Canon_500D:
        {
            title_v = @[@"off", @"on"];
        }
            break;
            
        default:
            break;
    }
    
    return [self assemblyDataWithParameter:title_v];
}

//对焦
+ (NSArray *)canonFocusWithModel:(Camera_Model)model
{
    return nil;
}

@end
