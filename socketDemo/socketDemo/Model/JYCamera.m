

#import "JYCamera.h"

@implementation JYCamera

- (instancetype)initWithTitle:(NSString *)title value:(Byte)value
{
    self = [super init];
    if (self) {
        self._values = title;
        self._value_send = value;
    }
    return self;
}

+ (NSArray *)cameraBrand
{
    NSMutableArray *brand_a = [NSMutableArray array];
    
    NSArray *set_v = @[@"Canon", @"Nikon", @"Sony", @"Panasonic"];
    for (int i = 0; i < set_v.count; i++) {
        JYCamera *brand = [[JYCamera alloc] init];
        brand._values = set_v[i];
        [brand_a addObject:brand];
    }
    
    return [brand_a copy];
}

+ (NSArray *)assemblyDataWithParameter:(NSArray *)parameter
{
    NSMutableArray *dataArr = [NSMutableArray array];
    
    Byte set_v[parameter.count];
    for (int i = 0; i < parameter.count; i++) {
        set_v[i] = (Byte) (i & 0xFF);
    }
    for (int i = 0; i < parameter.count; i++) {
        JYCamera *camera = [[JYCamera alloc] init];
        camera._values = parameter[i];
        camera._value_send = set_v[i];
        [dataArr addObject:camera];
    }
    
    return [dataArr copy];
}

@end
