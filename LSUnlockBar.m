#import "LSUnlockBar.h"

@implementation LSUnlockBar
@synthesize delegate;
//384 410

- (id)initWithFrame:(CGRect)frame
{
	if ((self = [super initWithFrame:frame]) != nil) {
		bottomBar = [[TPBottomBar alloc] initWithDefaultSize];
		[bottomBar setFrame:CGRectMake(0.0f,0.0f,320.0f,96.0f)];
		[self addSubview:bottomBar];
		button = [[TPPushButton alloc] initWithTitle:@"Slide Down To Unlock" icon:nil color:8 frame:CGRectMake(22.0f,26.0f,276.0f,50.0f) imageIsOptional:YES];
		[bottomBar addSubview:button];
		button.userInteractionEnabled = NO;
	}
	return self;
}

- (void)setTitle:(NSString *)title
{
	[button setPlusSeparatedTitle:title];
}

- (BOOL)checkFrame:(CGRect)frame
{
	return (frame.origin.y == 410.0f);
}

- (void)setTextAlpha:(float)alpha
{
	button.alpha = alpha;
}
	
	
@end