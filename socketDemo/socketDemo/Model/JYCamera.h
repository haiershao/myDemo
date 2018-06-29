

#import <Foundation/Foundation.h>

@interface JYCamera : NSObject

@property (nonatomic, strong) NSString *_values;
@property (nonatomic, assign) Byte _value_send;

- (instancetype)initWithTitle:(NSString *)title value:(Byte)value;

+ (NSArray *)cameraBrand;

+ (NSArray *)assemblyDataWithParameter:(NSArray *)parameter;

@end
