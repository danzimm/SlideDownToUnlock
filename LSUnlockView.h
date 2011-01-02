@interface NSObject (DelagteLSUnlockview)
- (void)unlock;
@end

@interface LSUnlockView : UIView {
	NSTimer *touchTimerUp;
	NSTimer *touchTimerDown;
	id delegate;
}

@property (nonatomic, assign) id delegate;
@end
