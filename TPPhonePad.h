/**
 * This header is generated by class-dump-z 0.2a.
 * class-dump-z is Copyright (C) 2009 by KennyTM~, licensed under GPLv3.
 *
 * Source: /System/Library/PrivateFrameworks/TelephonyUI.framework/TelephonyUI
 */

#import "TelephonyUI-Structs.h"
#import <UIKit/UIControl.h>
#import "TPPhonePad.h"


@interface TPPhonePad : UIControl {
	int _downKey;
	id _delegate;
	BOOL _playsSounds;
	float _topHeight;
	float _midHeight;
	float _bottomHeight;
	float _leftWidth;
	float _midWidth;
	float _rightWidth;
	CFSetRef _inflightSounds;
	CFDictionaryRef _keyToButtonMap;
	unsigned _incompleteSounds;
	unsigned _delegateSoundCallbacks : 1;
	unsigned _soundsActivated : 1;
}
+(BOOL)shouldStringAutoDial:(id)dial givenLastChar:(BOOL)aChar;
+(BOOL)launchFieldTestIfNeeded:(id)needed;
+(void)_delayedDeactivate;
-(id)initWithFrame:(CGRect)frame;
-(void)dealloc;
-(void)_activateSounds:(BOOL)sounds;
-(void)removeFromSuperview;
-(void)_appSuspended;
-(void)_appResumed;
-(void)movedFromWindow:(id)window;
-(void)movedToWindow:(id)window;
-(void)setDelegate:(id)delegate;
-(void)setPlaysSounds:(BOOL)sounds;
-(void)setButton:(id)button forKeyAtIndex:(int)index;
-(id)_buttonForKeyAtIndex:(int)index;
-(void)setNeedsDisplayForKey:(int)key;
-(CGPoint)_keypadOrigin;
-(id)_pressedImage;
-(id)_keypadImage;
-(float)_yFudge;
-(void)drawRect:(CGRect)rect;
-(BOOL)pointMostlyInside:(CGPoint)inside withEvent:(id)event;
-(id)hitTest:(CGPoint)test withEvent:(id)event;
-(void)setHighlighted:(BOOL)highlighted;
-(BOOL)cancelTouchTracking;
-(void)_handleKey:(id)key forUIEvent:(id)uievent;
-(void)_handleKeyPressAndHold:(id)hold;
-(int)_keyForPoint:(CGPoint)point;
-(CGRect)_rectForKey:(int)key;
-(void)_notifySoundCompletionIfNecessary:(unsigned long)necessary;
-(void)_playSoundForKey:(int)key;
-(void)_stopSoundForKey:(int)key;
-(void)_stopAllSoundsForcingCallbacks:(BOOL)callbacks;
@end

@interface TPPhonePad (SyntheticEvents)
-(id)scriptingInfoWithChildren;
@end

