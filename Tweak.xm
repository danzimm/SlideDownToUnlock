#import "SBAwayView.h"
#import "SBAwayController.h"
#import "SBSoundPreferences.h"
#import "LSMediaControlsView.h"

#import <objc/runtime.h>
#import <QuartzCore/CALayer.h>

#import "LSUnlockBar.h"
#import "LSUnlockSlider.h"

static LSUnlockBar *bottom;
static LSUnlockBar *top;
static LSUnlockSlider *slider;
static BOOL mediaControls = NO;
static LSMediaControlsView *mediaControlsView;

@interface SBAwayView (LSUnlocker)
- (void)isSyncing;
- (void)stoppedSyncing;
@end

%hook SBAwayView

- (void)alertDisplayWillBecomeVisible
{
	[[self topBar] setHidden:YES];
	[[self bottomBar] setHidden:YES];
	top = [[LSUnlockBar alloc] initWithFrame:CGRectMake(0.0f,20.0f,320.0f,96.0f)];
	[top setTitle:@"Slide Up To Cancel"];
	[top setTextAlpha:0.0f];
	[self addSubview:top];
	
	bottom = [[LSUnlockBar alloc] initWithFrame:CGRectMake(0.0f,384.0f,320.0f,96.0f)];
	[self addSubview:bottom];
	
	
	NSDateFormatter *dff = [[NSDateFormatter alloc] init];
	NSDateFormatter *df = [[NSDateFormatter alloc] init];
	[dff setDateStyle:NSDateFormatterShortStyle];
	[df setTimeStyle:NSDateFormatterShortStyle];
	slider = [[LSUnlockSlider alloc] initWithTitle:[NSString stringWithFormat:@"%@ | %@", [dff stringFromDate:[NSDate date]],[df stringFromDate:[NSDate date]]] icon:nil color:2 frame:CGRectMake(22.0f,46.0f,276.0f,50.0f) imageIsOptional:YES];
	[slider setDelegate:self];
	[slider setTop:top];
	[slider setBottom:bottom];
	[self addSubview:slider];
	[dff release];
	[df release];
	
	%orig;
}

- (void)updateInCallInfo
{
	if ([self shouldShowInCallInfo]) {
		[bottom setTitle:@"Slide Down To Answer"];
		[slider setPushButtonColor:0];
	} else if ([(SBAwayController *)[objc_getClass("SBAwayController") sharedAwayController] isSyncing]) {
		[self isSyncing];
	} else {
		[self stoppedSyncing];
	}
}

- (void)lockBarUnlocked:(id)unlocked
{
	[UIView beginAnimations:nil context:NULL];
	[top setFrame:CGRectMake(0.0f,-top.frame.size.height,top.frame.size.width, 0.0f)];
	[slider setFrame:CGRectMake(22.0f, 506.0f, 276.0f, 0.0f)];
	[bottom setFrame:CGRectMake(0.0f, 480.0f, 320.0f, 0.0f)];
	[UIView commitAnimations];
	%orig;
}

%new(v@:@)
- (void)checkView:(LSUnlockSlider *)view
{
	if (view.frame.origin.y >= 410.0f) {
		[self unlock];
	/*
		[UIView beginAnimations:nil context:NULL];
		view.frame = CGRectMake(22.0f,46.0f,276.0f,50.0f);
		[UIView commitAnimations];
	*/} else {
		[UIView beginAnimations:nil context:NULL];
		[top setTextAlpha:0.0f];
		[bottom setTextAlpha:1.0f];
		if (mediaControls) {
			view.frame = CGRectMake(22.0f,46.0f + 96.0f,276.0f,50.0f);
		} else {
			view.frame = CGRectMake(22.0f,46.0f,276.0f,50.0f);
		}
		[UIView commitAnimations];
	}
}

-(void)deviceUnlockCanceled
{
	%orig;
	slider.frame = CGRectMake(22.0f, top.frame.origin.y + 26.0f, 276.0f,50.0f);
	[top setTextAlpha:0.0f];
	[bottom setTextAlpha:1.0f];
	[UIView beginAnimations:nil context:NULL];
	top.frame = CGRectMake(0.0f,20.0f,320.0f,96.0f);
	slider.frame = CGRectMake(22.0f,46.0f,276.0f,50.0f);
	bottom.frame = CGRectMake(0.0f,384.0f,320.0f,96.0f);
	[UIView commitAnimations];
}

- (void)dismiss
{
	[top removeFromSuperview];
	[top release];
	top = nil;
	[bottom removeFromSuperview];
	[bottom release];
	bottom = nil;
	[slider removeFromSuperview];
	[slider release];
	slider = nil;
	if (mediaControls) {
		mediaControls = NO;
		[mediaControlsView removeFromSuperview];
		[mediaControlsView release];
		mediaControlsView = nil;
	}
	%orig;
}

%new(v@:)
- (void)unlock
{
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDelegate:slider];
	[UIView setAnimationDidStopSelector:@selector(finishedAnimatingOut)];
	[top setFrame:CGRectMake(0.0f,-top.frame.size.height,top.frame.size.width, 0.0f)];
	[slider setFrame:CGRectMake(22.0f, 506.0f, 276.0f, 0.0f)];
	[bottom setFrame:CGRectMake(0.0f, 480.0f, 320.0f, 0.0f)];
	if (mediaControls) {
		mediaControlsView.frame = CGRectMake(0.0f, -96.0f, 320.0f, 0.0f);
	}
	[UIView commitAnimations];
}

%new(v@:)
- (void)isSyncing
{
	[bottom setTitle:@"Slide Down To Stop Sync"];
	[slider setPushButtonColor:1];
}

%new(v@:)
- (void)stoppedSyncing
{
	[bottom setTitle:@"Slide Down To Unlock"];
	[slider setPushButtonColor:2];
}
	
%end

%hook SBAwayController

-(void)noteSyncStateChanged
{
	%orig;
	if ([self isSyncing]) {
		[(SBAwayView *)[self awayView] isSyncing];
	} else {
		[(SBAwayView *)[self awayView] stoppedSyncing];
	}
}

-(BOOL)handleMenuButtonDoubleTap
{
	BOOL orig = %orig;
	if (orig) {
		if (!mediaControls) {
			mediaControls = YES;
			mediaControlsView = [[LSMediaControlsView alloc] initWithFrame:CGRectMake(0.0f, -96.0f, 320.0f, 96.0f)];
			[(SBAwayView *)[self awayView] addSubview:mediaControlsView];
			[UIView beginAnimations:nil context:NULL];
			mediaControlsView.frame = CGRectMake(0.0f,20.0f,320.0f,96.0f);
			top.frame = CGRectMake(0.0f, top.frame.origin.y + 96.0f, 320.0f, 96.0f);
			slider.frame = CGRectMake(22.0f, slider.frame.origin.y + 96.0f, 276.0f, 50.0f);
			[UIView commitAnimations];
		} else {
			mediaControls = NO;
			[UIView beginAnimations:nil context:NULL];
			[UIView setAnimationDelegate:mediaControlsView];
			[UIView setAnimationDidStopSelector:@selector(animatedOut)];
			mediaControlsView.frame = CGRectMake(0.0f, -96.0f, 320.0f, 0.0f);
			top.frame = CGRectMake(0.0f, top.frame.origin.y - 96.0f, 320.0f, 96.0f);
			slider.frame = CGRectMake(22.0f, slider.frame.origin.y - 96.0f, 276.0f, 50.0f);
			[UIView commitAnimations];
		}
	}
	return orig;
}
	
- (void)undimScreen
{
	NSDateFormatter *dff = [[NSDateFormatter alloc] init];
	NSDateFormatter *df = [[NSDateFormatter alloc] init];
	[dff setDateStyle:NSDateFormatterShortStyle];
	[df setTimeStyle:NSDateFormatterShortStyle];
	[slider setPlusSeparatedTitle:[NSString stringWithFormat:@"%@ | %@", [dff stringFromDate:[NSDate date]],[df stringFromDate:[NSDate date]]]];
	[df release];
	[dff release];
	%orig;
}

%end

