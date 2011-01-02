#import "TelephonyUI.h"
#import "LSUnlockBar.h"

@interface LSUnlockSlider : TPPushButton {
	id delegate;
	LSUnlockBar *bottom;
	LSUnlockBar *top;
}

@property (nonatomic, assign) id delegate;
@property (nonatomic, assign) LSUnlockBar *bottom;
@property (nonatomic, assign) LSUnlockBar *top;
@end

@interface NSObject (ajsldk)
- (void)checkView:(LSUnlockSlider *)view;
@end