#import "TelephonyUI.h"

@interface NSObject (DelagteLSUnlockview)
- (void)unlock;
@end

@interface LSUnlockBar : UIView {
	TPBottomBar *bottomBar;
	TPPushButton *button;
}

- (void)setTitle:(NSString *)title;
- (BOOL)checkFrame:(CGRect)frame;
- (void)setTextAlpha:(float)alpha;

@property (nonatomic, assign) id delegate;
@end
