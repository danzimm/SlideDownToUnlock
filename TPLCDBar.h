/**
 * This header is generated by class-dump-z 0.2a.
 * class-dump-z is Copyright (C) 2009 by KennyTM~, licensed under GPLv3.
 *
 * Source: /System/Library/PrivateFrameworks/TelephonyUI.framework/TelephonyUI
 */

#import <UIKit/UIImageView.h>
#import "TelephonyUI-Structs.h"

@class UIImage;

@interface TPLCDBar : UIImageView {
	UIImage* _barBackground;
}
@property(retain, nonatomic) UIImage* barBackground;
+(void)preloadImages;
+(id)backgroundImage;
+(float)defaultHeight;
+(float)defaultHeightForOrientation:(int)orientation;
+(id)backgroundImageName;
-(id)initWithDefaultSizeForOrientation:(int)orientation;
-(id)initWithDefaultSize;
-(id)initWithFrame:(CGRect)frame;
-(void)dealloc;
-(void)setOrientation:(int)orientation;
-(CGRect)contentStretchRect;
@end

