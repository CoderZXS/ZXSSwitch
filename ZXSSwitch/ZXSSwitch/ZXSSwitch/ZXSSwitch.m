/*
     ZXSSwitch(https://github.com/CoderZXS/ZXSSwitch)
     Created by CoderZXS on 2016/4/12.
     Copyright © 2016年 CoderZXS. All rights reserved.
     模仿iOS7风格，实现Switch控件可以自定义文字
 */

#import "ZXSSwitch.h"

#define ZXSSwitchKnobWidth 28.0f
#define ZXSSwitchMaxHeight 31.0f
#define ZXSSwitchMinHeight 31.0f
#define ZXSSwitchMinWidth 51.0f

@interface ZXSSwitch ()

@property (weak, nonatomic) UIView *containerView;
@property (weak, nonatomic) UIView *onContentView;
@property (weak, nonatomic) UIView *offContentView;
@property (weak, nonatomic) UIView *knobView;
@property (weak, nonatomic) UILabel *onLabel;
@property (weak, nonatomic) UILabel *offLabel;

@end

@implementation ZXSSwitch

#pragma mark - 系统方法

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:[self roundRect:frame]]) {
        [self commonInit];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self commonInit];
    }
    
    return self;
}

- (void)setBounds:(CGRect)bounds {
    [super setBounds:[self roundRect:bounds]];
    [self setNeedsLayout];
}

- (void)setFrame:(CGRect)frame {
    [super setFrame:[self roundRect:frame]];
    [self setNeedsLayout];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat cornerRadius = CGRectGetHeight(self.containerView.bounds) * 0.5;
    CGFloat margin = (CGRectGetHeight(self.bounds) - ZXSSwitchKnobWidth) * 0.5;
    CGFloat lHeight = 20.0f;
    CGFloat lMargin = cornerRadius - (sqrtf(powf(cornerRadius, 2) - powf(lHeight / 2.0, 2))) + margin;
    
    self.containerView.frame = self.bounds;
    
    if (!self.isOn) {
        
        // frame of off status
        self.onContentView.frame = CGRectMake(-1 * CGRectGetWidth(self.containerView.bounds),
                                              0,
                                              CGRectGetWidth(self.containerView.bounds),
                                              CGRectGetHeight(self.containerView.bounds));
        
        self.offContentView.frame = CGRectMake(0,
                                               0,
                                               CGRectGetWidth(self.containerView.bounds),
                                               CGRectGetHeight(self.containerView.bounds));
        
        self.knobView.frame = CGRectMake(margin,
                                         margin,
                                         ZXSSwitchKnobWidth,
                                         ZXSSwitchKnobWidth);
    } else {
        
        // frame of on status
        self.onContentView.frame = CGRectMake(0,
                                              0,
                                              CGRectGetWidth(self.containerView.bounds),
                                              CGRectGetHeight(self.containerView.bounds));
        
        self.offContentView.frame = CGRectMake(0,
                                               CGRectGetWidth(self.containerView.bounds),
                                               CGRectGetWidth(self.containerView.bounds),
                                               CGRectGetHeight(self.containerView.bounds));
        
        self.knobView.frame = CGRectMake(CGRectGetWidth(self.containerView.bounds) - margin - ZXSSwitchKnobWidth,
                                         margin,
                                         ZXSSwitchKnobWidth,
                                         ZXSSwitchKnobWidth);
    }
    

    self.onLabel.frame = CGRectMake(lMargin,
                                    cornerRadius - lHeight * 0.5,
                                    CGRectGetWidth(self.onContentView.bounds) - lMargin - ZXSSwitchKnobWidth - 2 * margin,
                                    lHeight);
    
    self.offLabel.frame = CGRectMake(ZXSSwitchKnobWidth + 2 * margin,
                                     cornerRadius - lHeight * 0.5,
                                     CGRectGetWidth(self.onContentView.bounds) - lMargin - ZXSSwitchKnobWidth - 2 * margin,
                                     lHeight);
}




#pragma mark - 自定义方法

- (CGRect)roundRect:(CGRect)frameOrBounds {
    CGRect newRect = frameOrBounds;
    
    if (newRect.size.height > ZXSSwitchMaxHeight) {
        newRect.size.height = ZXSSwitchMaxHeight;
    }
    
    if (newRect.size.height < ZXSSwitchMinHeight) {
        newRect.size.height = ZXSSwitchMinHeight;
    }
    
    if (newRect.size.width < ZXSSwitchMinWidth) {
        newRect.size.width = ZXSSwitchMinWidth;
    }
    
    return newRect;
}

- (void)commonInit {
    
    self.backgroundColor = [UIColor clearColor];
    _onTintColor = [UIColor colorWithRed:97 / 255.0 green:219 / 255.0 blue:109 / 255.0 alpha:1.0];
    _tintColor = [UIColor colorWithWhite:0.75 alpha:1.0];
    _thumbTintColor = [UIColor colorWithWhite:1.0 alpha:1.0];
    _textFont = [UIFont systemFontOfSize:10.0f];
    _textColor = [UIColor whiteColor];
    
    [self setupUI];
    [self setupGesture];
}

// 添加子控件
- (void)setupUI {
    
    UIView *containerView = [[UIView alloc] initWithFrame:self.bounds];
    [self addSubview:containerView];
    self.containerView = containerView;
    containerView.backgroundColor = [UIColor clearColor];
    CGFloat cornerRadius = CGRectGetHeight(containerView.bounds) * 0.5;
    containerView.layer.cornerRadius = cornerRadius;
    containerView.layer.masksToBounds = YES;
    
    
    UIView *onContentView = [[UIView alloc] initWithFrame:self.bounds];
    [self.containerView addSubview:onContentView];
    self.onContentView = onContentView;
    onContentView.backgroundColor = _onTintColor;
    
    
    UIView *offContentView = [[UIView alloc] initWithFrame:self.bounds];
    [self.containerView addSubview:offContentView];
    self.offContentView = offContentView;
    offContentView.backgroundColor = _tintColor;
    
    
    UIView *knobView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ZXSSwitchKnobWidth, ZXSSwitchKnobWidth)];
    [self.containerView addSubview:knobView];
    self.knobView = knobView;
    knobView.backgroundColor = _thumbTintColor;
    knobView.layer.cornerRadius = ZXSSwitchKnobWidth * 0.5;
    
    
    UILabel *onLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    [self.onContentView addSubview:onLabel];
    self.onLabel = onLabel;
    onLabel.backgroundColor = [UIColor clearColor];
    onLabel.textAlignment = NSTextAlignmentCenter;
    onLabel.textColor = _textColor;
    onLabel.font = _textFont;
    onLabel.text = _onText;
    
    
    UILabel *offLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    [self.offContentView addSubview:offLabel];
    self.offLabel = offLabel;
    offLabel.backgroundColor = [UIColor clearColor];
    offLabel.textAlignment = NSTextAlignmentCenter;
    offLabel.textColor = _textColor;
    offLabel.font = _textFont;
    offLabel.text = _offText;
}

// 添加手势
- (void)setupGesture {
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapTapGestureRecognizerEvent:)];
    [self addGestureRecognizer:tapGesture];
    
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanGestureRecognizerEvent:)];
    [self addGestureRecognizer:panGesture];
}

- (void)setOnText:(NSString *)onText {
    if (_onText != onText) {
        
        _onText = onText;
        _onLabel.text = onText;
    }
}

- (void)setOffText:(NSString *)offText {
    if (_offText != offText) {
        
        _offText = offText;
        _offLabel.text = offText;
    }
}

- (void)setOnTintColor:(UIColor *)onTintColor {
    if (_onTintColor != onTintColor) {
        
        _onTintColor = onTintColor;
        _onContentView.backgroundColor = onTintColor;
    }
}

- (void)setTintColor:(UIColor *)tintColor {
    if (_tintColor != tintColor) {
        
        _tintColor = tintColor;
        _offContentView.backgroundColor = tintColor;
    }
}

- (void)setThumbTintColor:(UIColor *)thumbTintColor {
    if (_thumbTintColor != thumbTintColor) {
        
        _thumbTintColor = thumbTintColor;
        _knobView.backgroundColor = _thumbTintColor;
    }
}


- (void)setOn:(BOOL)on {
    [self setOn:on animated:NO];
}

- (void)setOn:(BOOL)on animated:(BOOL)animated {
    if (_on == on) {
        return;
    }
    
    _on = on;
    
    CGFloat margin = (CGRectGetHeight(self.bounds) - ZXSSwitchKnobWidth) * 0.5;
    
    if (!animated) {
        if (!self.isOn) {
            // frame of off status
            self.onContentView.frame = CGRectMake(-1 * CGRectGetWidth(self.containerView.bounds),
                                                  0,
                                                  CGRectGetWidth(self.containerView.bounds),
                                                  CGRectGetHeight(self.containerView.bounds));
            
            self.offContentView.frame = CGRectMake(0,
                                                   0,
                                                   CGRectGetWidth(self.containerView.bounds),
                                                   CGRectGetHeight(self.containerView.bounds));
            
            self.knobView.frame = CGRectMake(margin,
                                             margin,
                                             ZXSSwitchKnobWidth,
                                             ZXSSwitchKnobWidth);
        } else {
            // frame of on status
            self.onContentView.frame = CGRectMake(0,
                                                  0,
                                                  CGRectGetWidth(self.containerView.bounds),
                                                  CGRectGetHeight(self.containerView.bounds));
            
            self.offContentView.frame = CGRectMake(0,
                                                   CGRectGetWidth(self.containerView.bounds),
                                                   CGRectGetWidth(self.containerView.bounds),
                                                   CGRectGetHeight(self.containerView.bounds));
            
            self.knobView.frame = CGRectMake(CGRectGetWidth(self.containerView.bounds) - margin - ZXSSwitchKnobWidth,
                                             margin,
                                             ZXSSwitchKnobWidth,
                                             ZXSSwitchKnobWidth);
        }
    } else {
        if (self.isOn) {
            [UIView animateWithDuration:0.25
                             animations:^{
                                 self.knobView.frame = CGRectMake(CGRectGetWidth(self.containerView.bounds) - margin - ZXSSwitchKnobWidth,
                                                                  margin,
                                                                  ZXSSwitchKnobWidth,
                                                                  ZXSSwitchKnobWidth);
                             }
                             completion:^(BOOL finished){
                                 self.onContentView.frame = CGRectMake(0,
                                                                       0,
                                                                       CGRectGetWidth(self.containerView.bounds),
                                                                       CGRectGetHeight(self.containerView.bounds));
                                 
                                 self.offContentView.frame = CGRectMake(0,
                                                                        CGRectGetWidth(self.containerView.bounds),
                                                                        CGRectGetWidth(self.containerView.bounds),
                                                                        CGRectGetHeight(self.containerView.bounds));
                             }];
        } else {
            [UIView animateWithDuration:0.25
                             animations:^{
                                 self.knobView.frame = CGRectMake(margin,
                                                                  margin,
                                                                  ZXSSwitchKnobWidth,
                                                                  ZXSSwitchKnobWidth);
                             }
                             completion:^(BOOL finished){
                                 self.onContentView.frame = CGRectMake(-1 * CGRectGetWidth(self.containerView.bounds),
                                                                       0,
                                                                       CGRectGetWidth(self.containerView.bounds),
                                                                       CGRectGetHeight(self.containerView.bounds));
                                 
                                 self.offContentView.frame = CGRectMake(0,
                                                                        0,
                                                                        CGRectGetWidth(self.containerView.bounds),
                                                                        CGRectGetHeight(self.containerView.bounds));
                             }];
        }
    }
    
    [self sendActionsForControlEvents:UIControlEventValueChanged];
}




#pragma mark - 手势处理
- (void)handleTapTapGestureRecognizerEvent:(UITapGestureRecognizer *)recognizer {
    if (recognizer.state == UIGestureRecognizerStateEnded) {
        [self setOn:!self.isOn animated:YES];
    }
}

- (void)handlePanGestureRecognizerEvent:(UIPanGestureRecognizer *)recognizer {
    CGFloat margin = (CGRectGetHeight(self.bounds) - ZXSSwitchKnobWidth) / 2.0;
    CGFloat offset = 6.0f;
    
    switch (recognizer.state) {
        case UIGestureRecognizerStateBegan:{
            if (!self.isOn) {
                [UIView animateWithDuration:0.25
                                 animations:^{
                                     self.knobView.frame = CGRectMake(margin,
                                                                      margin,
                                                                      ZXSSwitchKnobWidth + offset,
                                                                      ZXSSwitchKnobWidth);
                                 }];
            } else {
                [UIView animateWithDuration:0.25
                                 animations:^{
                                     self.knobView.frame = CGRectMake(CGRectGetWidth(self.containerView.bounds) - margin - (ZXSSwitchKnobWidth + offset),
                                                                      margin,
                                                                      ZXSSwitchKnobWidth + offset,
                                                                      ZXSSwitchKnobWidth);
                                 }];
            }
            break;
        }
        case UIGestureRecognizerStateCancelled:
        case UIGestureRecognizerStateFailed: {
            if (!self.isOn) {
                [UIView animateWithDuration:0.25
                                 animations:^{
                                     self.knobView.frame = CGRectMake(margin,
                                                                      margin,
                                                                      ZXSSwitchKnobWidth,
                                                                      ZXSSwitchKnobWidth);
                                 }];
            } else {
                [UIView animateWithDuration:0.25
                                 animations:^{
                                     self.knobView.frame = CGRectMake(CGRectGetWidth(self.containerView.bounds) - ZXSSwitchKnobWidth,
                                                                      margin,
                                                                      ZXSSwitchKnobWidth,
                                                                      ZXSSwitchKnobWidth);
                                 }];
            }
            break;
        }
        case UIGestureRecognizerStateChanged:{
            break;
        }
        case UIGestureRecognizerStateEnded:
            [self setOn:!self.isOn animated:YES];
            break;
        case UIGestureRecognizerStatePossible:
            break;
    }
}

@end
