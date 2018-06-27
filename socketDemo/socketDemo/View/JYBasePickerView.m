//
//  JYBasePickerView.m
//  SLR_PTZ
//
//  Created by 海二少 on 2018/4/24.
//  Copyright © 2018年 JIYI. All rights reserved.
//

#import "JYBasePickerView.h"
#import "UIView+Extension.h"
#define screenW [UIScreen mainScreen].bounds.size.width
#define screenH [UIScreen mainScreen].bounds.size.height
#define kColor(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:a]
@interface JYBasePickerView ()<UIGestureRecognizerDelegate>

@end

@implementation JYBasePickerView

- (void)awakeFromNib{
    
    [super awakeFromNib];
    self.backgroundColor = kColor(0, 0,0, 0.5);
    [self.layer setFrame:CGRectMake(0, 10, screenW, self.height)];
    
    UITapGestureRecognizer *tapGesture0 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(viewTapClick:)];
    tapGesture0.delegate = self;
    [self addGestureRecognizer:tapGesture0];
}

- (void)viewTapClick:(UITapGestureRecognizer *)sender {
    [self removeFromSuperview];
    if ([self.delegate respondsToSelector:@selector(basePickerView:cancelBtn:)]) {
        [self.delegate basePickerView:self cancelBtn:nil];
    }
}

- (IBAction)cancelBtnClick:(UIButton *)sender {
    [self removeFromSuperview];
    if ([self.delegate respondsToSelector:@selector(basePickerView:cancelBtn:)]) {
        [self.delegate basePickerView:self cancelBtn:sender];
    }
}

- (IBAction)confirmBtnClick:(UIButton *)sender {
    
    [self removeFromSuperview];
    if ([self.delegate respondsToSelector:@selector(basePickerView:confirmBtn:)]) {
        [self.delegate basePickerView:self confirmBtn:sender];
    }
}

+ (instancetype)basePickerView{
    
    return [[[NSBundle mainBundle] loadNibNamed:@"JYBasePickerView" owner:self options:nil] lastObject];
}

@end
