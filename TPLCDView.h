/**
 * This header is generated by class-dump-z 0.2a.
 * class-dump-z is Copyright (C) 2009 by KennyTM~, licensed under GPLv3.
 *
 * Source: /System/Library/PrivateFrameworks/TelephonyUI.framework/TelephonyUI
 */

#import "TelephonyUI-Structs.h"
#import "TPLCDBar.h"

@class TPLCDTextView, TPLCDSubImageView;

@interface TPLCDView : TPLCDBar {
	TPLCDTextView* _textView;
	TPLCDTextView* _secondLineTextView;
	TPLCDTextView* _labelView;
	TPLCDSubImageView* _imageView;
	unsigned _layoutAsLabelled : 1;
}
+(float)textFontSize;
+(float)labelFontSize;
-(void)dealloc;
-(void)setContentsAlpha:(float)alpha;
-(CGRect)_text1Frame;
-(void)setText:(id)text;
-(id)text;
-(CGRect)textFrame;
-(CGRect)_text2Frame;
-(void)setSecondLineText:(id)text;
-(id)secondLineText;
-(CGRect)_labelFrame;
-(void)didFinishAnimatingLCDLabelFadeOut:(id)anOut finished:(id)finished context:(id)context;
-(void)setLabel:(id)label animate:(BOOL)animate;
-(void)setLabel:(id)label;
-(id)label;
-(void)blinkLabel;
-(void)setSubImage:(id)image;
-(id)subImage;
-(void)setShadowColor:(id)color;
-(void)setLayoutAsLabelled:(BOOL)labelled;
-(void)layoutSubviews;
@end

