//
//  BLSwitch.m
//  BLSwitch
//
//  Created by Manco on 2019/6/3.
//  Copyright © 2019 Manco. All rights reserved.
//

#import "BLSwitch.h"

#define blselect_width  24
#define blselect_height  27
#define blswitch_modulewidth  63
#define blswitch_height  blselect_height
#define blswitch_width (blswitch_modulewidth + blswitch_height)
#define blSwitchStringIsEmpty(str) ([str isKindOfClass:[NSNull class]] || [[NSString stringWithFormat:@"%@",str] isEqualToString: @"(null)"] ||[[NSString stringWithFormat:@"%@",str] isEqualToString: @""]|| str == nil || [[NSString stringWithFormat:@"%@",str] length] < 1 ? YES : NO )

@interface BLSwitch()
@property (nonatomic,strong)UIView *contentView;
@property (nonatomic,strong)UILabel *leftLabel;
@property (nonatomic,strong)UILabel *rightLabel;
@property (nonatomic,strong)UIView *selectView;
@end


@implementation BLSwitch

@synthesize tintColor = _tintColor;
@synthesize thumbTintOffTitleColor = _thumbTintOffTitleColor;
@synthesize thumbTintTitleDefaultColor = _thumbTintTitleDefaultColor;
@synthesize thumbTintOnColor = _thumbTintOnColor;
@synthesize thumbTintOnTitleColor = _thumbTintOnTitleColor;
@synthesize thumbTintOffColor = _thumbTintOffColor;
@synthesize leftTintTitle = _leftTintTitle;
@synthesize rightTintTitle = _rightTintTitle;


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpSubview];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.backgroundColor = [UIColor clearColor];
}

-(void)setUpSubview{

    self.bounds = CGRectMake(0, 0, blswitch_width, blswitch_height);
    [self addSubview:self.contentView];
    [self.contentView addSubview:self.selectView];
    [self.contentView addSubview:self.leftLabel];
    [self.contentView addSubview:self.rightLabel];
    
    [self addTarget:self action:@selector(changeSelectedState:) forControlEvents:UIControlEventTouchUpInside];
    [self updateState];
}

-(void)changeSelectedState:(BLSwitch *)obj{
    self.isOn = !self.isOn;
    if (self.valueChangedBlock) {
        self.valueChangedBlock(self.isOn);
    }
    [self playVibration];
}

-(void)updateState{
    if (blSwitchStringIsEmpty(self.leftTintTitle)) {
        self.leftLabel.hidden = YES;
    }else{
        self.leftLabel.hidden = NO;
        self.leftLabel.text = self.leftTintTitle;
    }
    
    if (blSwitchStringIsEmpty(self.rightTintTitle)) {
        self.rightLabel.hidden = YES;
    }else{
        self.rightLabel.hidden = NO;
        self.rightLabel.text = self.rightTintTitle;
    }
    if (self.isRightOn) {
        if (self.isOn) {
            [UIView animateWithDuration:0.1 animations:^{
                //更新位置
                CGRect rect = self.selectView.frame;
                rect.origin.x = blswitch_width-blselect_width-blselect_height;
                self.selectView.frame = rect;
                //更新颜色
                self.rightLabel.textColor = self.thumbTintOnTitleColor;
                self.selectView.backgroundColor = self.thumbTintOnColor;
                self.leftLabel.textColor = self.thumbTintTitleDefaultColor;
            }];
        }else{
            [UIView animateWithDuration:0.1 animations:^{
                //更新位置
                CGRect rect = self.selectView.frame;
                rect.origin.x = 0;
                self.selectView.frame = rect;
                //更新颜色
                self.leftLabel.textColor = self.thumbTintOffTitleColor;
                self.selectView.backgroundColor = self.thumbTintOffColor;
                self.rightLabel.textColor = self.thumbTintTitleDefaultColor;
            }];
        }
    }else{
        if (self.isOn) {
            [UIView animateWithDuration:0.1 animations:^{
                //更新位置
                CGRect rect = self.selectView.frame;
                rect.origin.x = 0;
                self.selectView.frame = rect;
                //更新颜色
                self.leftLabel.textColor = self.thumbTintOnTitleColor;
                self.selectView.backgroundColor = self.thumbTintOnColor;
                self.rightLabel.textColor = self.thumbTintTitleDefaultColor;
            }];
        }else{
            [UIView animateWithDuration:0.1 animations:^{
                //更新位置
                CGRect rect = self.selectView.frame;
                rect.origin.x = blswitch_width-blselect_width-blselect_height;
                self.selectView.frame = rect;
                //更新颜色
                self.rightLabel.textColor = self.thumbTintOffTitleColor;
                self.selectView.backgroundColor = self.thumbTintOffColor;
                self.leftLabel.textColor = self.thumbTintTitleDefaultColor;
            }];
        }
    }
}
- (void)playVibration
{
    NSString *version = [UIDevice currentDevice].systemVersion;
    if (version.doubleValue >= 10.0) {
        UIImpactFeedbackGenerator *impactLight = [[UIImpactFeedbackGenerator alloc] initWithStyle:UIImpactFeedbackStyleLight];
        [impactLight impactOccurred];
    }
}
#pragma mark -========重写============
-(void)setIsOn:(BOOL)isOn{
    _isOn = isOn;
    [self updateState];
}

-(void)setIsRightOn:(BOOL)isRightOn{
    _isRightOn = isRightOn;
    [self updateState];
}

-(UIColor *)thumbTintOnColor{
    if (_thumbTintOnColor == nil) {
        _thumbTintOnColor = [UIColor colorWithRed:0/255.0 green:203/255.0 blue:132/255.0 alpha:1];
    }
    return _thumbTintOnColor;
}

-(void)setThumbTintOnColor:(UIColor *)thumbTintOnColor{
    if (thumbTintOnColor == nil) {
        _thumbTintOnColor = [UIColor colorWithRed:0/255.0 green:203/255.0 blue:132/255.0 alpha:1];
    }else{
        _thumbTintOnColor = thumbTintOnColor;
    }
    [self updateState];
}

-(UIColor *)thumbTintOnTitleColor{
    if (_thumbTintOnTitleColor == nil) {
        _thumbTintOnTitleColor = [UIColor whiteColor];
    }
    return _thumbTintOnTitleColor;
}

-(void)setThumbTintOnTitleColor:(UIColor *)thumbTintOnTitleColor{
    if (thumbTintOnTitleColor == nil) {
        _thumbTintOnTitleColor = [UIColor whiteColor];
    }else{
        _thumbTintOnTitleColor = thumbTintOnTitleColor;
    }
    [self updateState];
}


-(UIColor *)thumbTintOffColor{
    if (_thumbTintOffColor == nil) {
        _thumbTintOffColor = [UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1];
    }
    return _thumbTintOffColor;
}

-(void)setThumbTintOffColor:(UIColor *)thumbTintOffColor{
    if (thumbTintOffColor == nil) {
        _thumbTintOffColor = [UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1];
    }else{
      _thumbTintOffColor = thumbTintOffColor;
    }
    [self updateState];
}

-(UIColor *)thumbTintOffTitleColor{
    if (_thumbTintOffTitleColor == nil) {
        _thumbTintOffTitleColor = [UIColor whiteColor];
    }
    return _thumbTintOffTitleColor;
}

-(void)setThumbTintOffTitleColor:(UIColor *)thumbTintOffTitleColor{
    if (thumbTintOffTitleColor == nil) {
        _thumbTintOffTitleColor = [UIColor whiteColor];
    }else{
        _thumbTintOffTitleColor = thumbTintOffTitleColor;
    }
    [self updateState];
}

-(void)setLeftTintTitle:(UIColor *)leftTintTitle{
    if (leftTintTitle) {
        _leftTintTitle = [leftTintTitle copy];
        [self updateState];
    }
}
-(void)setRightTintTitle:(NSString *)rightTintTitle{
    if (rightTintTitle) {
        _rightTintTitle = [rightTintTitle copy];
        [self updateState];
    }
}

-(UIColor *)thumbTintTitleDefaultColor{
    if (_thumbTintTitleDefaultColor == nil) {
        _thumbTintTitleDefaultColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1];
    }
    return _thumbTintTitleDefaultColor;
}

-(void)setThumbTintTitleDefaultColor:(UIColor *)thumbTintTitleDefaultColor{
    if (thumbTintTitleDefaultColor == nil) {
        _thumbTintTitleDefaultColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1];
    }else{
        _thumbTintTitleDefaultColor = thumbTintTitleDefaultColor;
    }
    [self updateState];
}

- (UIColor *)tintColor{
    if (_tintColor == nil) {
        _tintColor = [UIColor colorWithRed:236/255.0 green:236/255.0 blue:236/255.0 alpha:1];
    }
    
    return _tintColor;
}

- (void)setTintColor:(UIColor *)tintColor{
    if (tintColor == nil) {
        _tintColor = [UIColor colorWithRed:236/255.0 green:236/255.0 blue:236/255.0 alpha:1];
    }else{
        _tintColor = tintColor;
    }
}

-(UIView *)contentView{
    if (_contentView == nil) {
        _contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, blswitch_width, blswitch_height)];
        _contentView.backgroundColor = self.tintColor;
        _contentView.userInteractionEnabled = NO;
        _contentView.layer.cornerRadius = _contentView.bounds.size.height*0.5;
        _contentView.layer.masksToBounds = YES;
    }
    return _contentView;
}

-(UILabel *)leftLabel{
    if (_leftLabel == nil) {
        _leftLabel = [[UILabel alloc] initWithFrame:CGRectMake(blswitch_height*0.5, 0, blselect_width, blselect_height)];
        _leftLabel.textAlignment = NSTextAlignmentCenter;
        _leftLabel.font = [UIFont systemFontOfSize:14];
        _leftLabel.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1];
        _leftLabel.userInteractionEnabled = NO;
    }
    return _leftLabel;
}

-(UILabel *)rightLabel{
    if (_rightLabel == nil) {
        _rightLabel = [[UILabel alloc] initWithFrame:CGRectMake(blswitch_width-blselect_width-blselect_height*0.5, 0, blselect_width, blselect_height)];
        _rightLabel.textAlignment = NSTextAlignmentCenter;
        _rightLabel.font = [UIFont systemFontOfSize:14];
        _rightLabel.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1];
        _rightLabel.userInteractionEnabled = NO;
    }
    return _rightLabel;
}

-(UIView *)selectView{
    if (_selectView == nil) {
        _selectView = [[UIView alloc] init];
        _selectView.userInteractionEnabled = NO;
        _selectView.frame = CGRectMake(0, 0, blselect_width+blselect_height, blselect_height);
        _selectView.layer.cornerRadius = _contentView.bounds.size.height*0.5;
        _selectView.layer.masksToBounds = YES;
    }
    return _selectView;
}
@end
