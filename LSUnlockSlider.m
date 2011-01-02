#import "LSUnlockSlider.h"
#import <objc/runtime.h>
#import "SBAwayController.h"
#import "SBSoundPreferences.h"

static CGPoint place;

@implementation LSUnlockSlider
@synthesize delegate;
@synthesize top;
@synthesize bottom;

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
//	[super touchesBegan:touches withEvent:event];
	UITouch *touch = [touches anyObject];
	place = [touch locationInView:self];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
//	[super touchesMoved:touches withEvent:event];
	UITouch *touch = [touches anyObject];
	CGPoint pplace = [touch locationInView:self];
	if ((pplace.y - place.y) < 0) {
		if (self.frame.origin.y > 46.0f) {
			self.center = CGPointMake(self.center.x, self.center.y + (pplace.y - place.y));
		}
	} else {
		if (self.frame.origin.y < 410.0f) {
			self.center = CGPointMake(self.center.x, self.center.y + (pplace.y - place.y));
		}
	}
	if (self.frame.origin.y > 410.0f) {
		self.frame = CGRectMake(self.frame.origin.x, 410.0f, self.frame.size.width, self.frame.size.height);
	} else if (self.frame.origin.y < 46.0f) {
		self.frame = CGRectMake(self.frame.origin.x, 46.0f, self.frame.size.width, self.frame.size.height);
	}
	float delta = (self.frame.origin.y - (top.frame.origin.y + 26.0f))/(410.0f - (top.frame.origin.y + 26.0f));
	[top setTextAlpha:delta];
	[bottom setTextAlpha:(1 - delta)];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
//	[super touchesEnded:touches withEvent:event];
	[delegate checkView:self];
}

- (void)finishedAnimatingOut
{
	[[objc_getClass("SBAwayController") sharedAwayController] unlockWithSound:[objc_getClass("SBSoundPreferences") playLockSound]];
}

@end