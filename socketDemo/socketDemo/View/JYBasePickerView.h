//
//  JYBasePickerView.h
//  SLR_PTZ
//
//  Created by 海二少 on 2018/4/24.
//  Copyright © 2018年 JIYI. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JYBasePickerView;
@protocol JYBasePickerViewDelegate <NSObject>

- (void)basePickerView:(JYBasePickerView *)basePickerView confirmBtn:(UIButton *)confirmBtn;

- (void)basePickerView:(JYBasePickerView *)basePickerView cancelBtn:(UIButton *)ccancelBtn;
@end
@interface JYBasePickerView : UIView
@property (weak, nonatomic) IBOutlet UIView *basePickerSubView;

@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subTitleLabel;

@property (weak, nonatomic) id<JYBasePickerViewDelegate>delegate;
+ (instancetype)basePickerView;
@end
