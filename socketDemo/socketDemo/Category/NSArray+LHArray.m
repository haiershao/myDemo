//
//  NSArray+LHArray.m
//  CocoSocketDemo
//
//  Created by 海二少 on 2018/6/7.
//  Copyright © 2018年 LGQ. All rights reserved.
//

#import "NSArray+LHArray.h"
#import "NSString+LHString.h"
@implementation NSArray (LHArray)
+ (int)arrayConverIntWithArray:(NSArray *)array{
    NSString *appendStr = @"";
    for (NSString *tempStr in array) {
        appendStr = [appendStr stringByAppendingString:tempStr];
    }
    NSArray *tempArr = [NSString snalysisWithResponseTwoString:appendStr];
    tempArr = [[tempArr reverseObjectEnumerator] allObjects];
    NSString *text = [tempArr componentsJoinedByString:@""];
    NSLog(@"arrayConverIntWithArray>>> %@",text);
    NSNumber *tempResult = [NSString numberHexString:text];
    //    NSString *text = @"0x0373db";
    int result = [tempResult intValue];
    return result;
}

+ (long)arrayConverIntWithString:(NSString *)valueStr{
    NSString *tempStr = valueStr;
    long result = 0;
    if (4 == valueStr.length) {
        NSString *str0 = [tempStr substringWithRange:NSMakeRange(0, 2)];
        NSString *str1 = [tempStr substringWithRange:NSMakeRange(2, 2)];
        tempStr = [str1 stringByAppendingString:str0];
        NSNumber *tempResult = [NSString numberHexString:tempStr];
        result = [tempResult longLongValue];
    }else if (2 == valueStr.length){
        NSNumber *tempResult = [NSString numberHexString:tempStr];
        result = [tempResult longLongValue];
    }else{
        result = 0;
    }
//    NSLog(@"arrayConverIntWithString %ld--%@",result,tempStr);
    return result;
}
@end
