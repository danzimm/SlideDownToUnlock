TWEAK_NAME = SlideDown
SlideDown_OBJCC_FILES = Tweak.mm
SlideDown_OBJC_FILES = LSUnlockBar.m \
	LSUnlockSlider.m \
	LSMediaControlsView.m
SlideDown_FRAMEWORKS = UIKit Foundation CoreFoundation CoreGraphics QuartzCore
SlideDown_PRIVATE_FRAMEWORKS = TelephonyUI

include framework/makefiles/common.mk
include framework/makefiles/tweak.mk

