#import "Headers.h"
#import "MediaRemote.h"
#import "CBAutoScrollLabel/CBAutoScrollLabel.h"
#import <MediaPlayer/MediaPlayer.h>
#import "RSPlayPauseButton/RSPlayPauseButton.h"
#import <QuartzCore/QuartzCore.h>

@interface Ouria : UIView {
	UIView *playerView;
  UIImageView *playerArtwork;
  RSPlayPauseButton *playPauseButton;
  UIView *nowPlayingView;
  UIImageView *nowPlayingViewArtwork;
  CBAutoScrollLabel *titleLabel;
  CBAutoScrollLabel *artistLabel;
  MPUChronologicalProgressView *trackProgressView;
  UISlider *volumeSlider;
}
+ (instancetype)sharedInstance;
- (void)openNowPlayingView;
- (void)playPauseButtonDidPress:(RSPlayPauseButton *)playPauseButton;
- (void)setPlayPause;
@end
