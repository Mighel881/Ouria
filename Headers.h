#import <QuartzCore/QuartzCore.h>

#define DEGREES_TO_RADIANS(degrees) (( degrees) / 180.0 * M_PI)

@interface MPUMediaControlsVolumeView : UIView
@property (nonatomic, readonly) UISlider *slider;
- (id)initWithStyle:(int)arg1;
@end

@interface MPDetailScrubController : NSObject
@property (nonatomic) BOOL detailedScrubbingEnabled;
@end

@interface MPUChronologicalProgressView : UIView
@property (nonatomic) double currentTime;
@property (nonatomic) double totalDuration;
@property (nonatomic, assign) id delegate;
@property (nonatomic) BOOL scrubbingEnabled;
- (void)setScrubbingEnabled:(BOOL)arg1;
- (id)initWithStyle:(int)style;
@end

@interface SBLockScreenView : UIView
- (void)verticalStartTimer;
- (void)verticalUpdateNowPlaying;
- (void)updateVolume:(NSNotification *)notification;
@end

@interface MPUNowPlayingController : NSObject
- (id)nowPlayingAppDisplayID;
@end

@interface SBLockScreenNotificationListView : UIView
-(void) updateForAdditionOfItemAtIndex:(unsigned int)index allowHighlightOnInsert:(BOOL)insert;
@end
