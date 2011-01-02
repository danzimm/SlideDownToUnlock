#import "LSUnlockView.h"

@implementation LSUnlockView
@synthesize delegate;


- (id)initWithFrame:(CGRect)frame
{
	if ((self = [super initWithFrame:frame]) != nil) {
		self.alpha = 0.1f;
		self.backgroundColor = [UIColor whiteColor];
	}
	return self;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	[super touchesBegan:touches withEvent:event];
	if (self.alpha >= 0.2f) {
		[delegate unlock];
	} else {
		touchTimerUp = [NSTimer scheduledTimerWithTimeInterval:0.1/1 target:self selector:@selector(timerFiredUp:) userInfo:nil repeats:YES];
		[touchTimerUp description];
	}
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
	[super touchesEnded:touches withEvent:event];
	if ([touchTimerUp isValid])
		[touchTimerUp invalidate];
	touchTimerDown = [NSTimer scheduledTimerWithTimeInterval:0.1/1 target:self selector:@selector(timerFiredDown:) userInfo:nil repeats:YES];
	[touchTimerDown description];
}

- (void)timerFiredUp:(NSTimer *)timer
{
	if (self.alpha < 1.0f) {
		self.alpha += 0.1f;
	} else {
		[timer invalidate];
	}
}

- (void)timerFiredDown:(NSTimer *)timer
{
	if (self.alpha >= 0.2f) {
		self.alpha -= 0.1f;
	} else {
		[timer invalidate];
	}
}

@end