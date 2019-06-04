//
//  BLSwitch.h
//  BLSwitch
//
//  Created by Manco on 2019/6/3.
//  Copyright © 2019 Manco. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^valueChangedHandle)(BOOL isOn);

@interface BLSwitch : UIControl
///选中打开滑块颜色
@property(nullable, nonatomic, strong) UIColor *thumbTintOnColor;
///选中打开滑块上的字体颜色
@property(nullable, nonatomic, strong) UIColor *thumbTintOnTitleColor;
///选中关闭滑块颜色
@property(nullable, nonatomic, strong) UIColor *thumbTintOffColor;
///选中关闭滑块上的字体颜色
@property(nullable, nonatomic, strong) UIColor *thumbTintOffTitleColor;
///未被选中默认初始的字体颜色
@property(nullable, nonatomic, strong) UIColor *thumbTintTitleDefaultColor;
///左边按钮文字
@property(nullable, nonatomic, copy) NSString *leftTintTitle;
///右边按钮文字
@property(nullable, nonatomic, copy) NSString *rightTintTitle;
///默认背景颜色
@property(null_resettable, nonatomic, strong) UIColor *tintColor;
///是否开启
@property(nonatomic, assign) BOOL isOn;
///是否是右边开启  默认左边开启
@property(nonatomic, assign) BOOL isRightOn;

///值改变回调
@property(nonatomic, copy)valueChangedHandle valueChangedBlock;
@end

NS_ASSUME_NONNULL_END
