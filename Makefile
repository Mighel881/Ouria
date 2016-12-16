TARGET = iphone:9.2

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = Ouria
Ouria_FILES = Tweak.xm CBAutoScrollLabel/CBAutoScrollLabel.m RSPlayPauseButton/RSPlayPauseButton.m
Ouria_PRIVATE_FRAMEWORKS = MediaRemote MediaPlayerUI
Ouria_FRAMEWORKS = Social
Ouria_CFLAGS = -O2
Tweak.xm_ADDITIONAL_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 SpringBoard"
SUBPROJECTS += ouria
include $(THEOS_MAKE_PATH)/aggregate.mk
