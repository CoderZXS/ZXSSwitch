

#import <UIKit/UIKit.h>

@interface ZXSSwitch : UIControl

@property (nonatomic, assign, getter = isOn) BOOL on;

@property (strong, nonatomic) UIColor *onTintColor;
@property (strong, nonatomic) UIColor *tintColor;
@property (strong, nonatomic) UIColor *thumbTintColor;

@property (strong, nonatomic) UIColor *textColor;
@property (strong, nonatomic) UIFont *textFont;
@property (strong, nonatomic) NSString *onText;
@property (strong, nonatomic) NSString *offText;

- (void)setOn:(BOOL)on animated:(BOOL)animated;

@end
