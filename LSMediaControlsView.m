#import "LSMediaControlsView.h"
#import "SBAwayMediaControlsView.h"
#import <objc/runtime.h>

@implementation LSMediaControlsView

- (id)initWithFrame:(CGRect)frame
{
	if ((self = [super initWithFrame:frame]) != nil) {
		background = [[TPLCDView alloc] initWithDefaultSize];
		controls = [[objc_getClass("SBAwayMediaControlsView") alloc] initWithFrame:background.frame];
		controls.center = CGPointMake(CGRectGetMidX(background.frame), CGRectGetMidY(background.frame));
		[background addSubview:controls];
		[self addSubview:background];
	}
	return self;
}
	
@end