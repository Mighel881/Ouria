#import "Ouria.h"

@implementation Ouria

+ (id)sharedInstance {
    static dispatch_once_t p = 0;
    __strong static id _sharedObject = nil;
    dispatch_once(&p, ^{
        _sharedObject = [[self alloc] init];
    });
    return _sharedObject;
}

- (instancetype)init {
  if (self = [super init]) {
    playerView = [[UIView alloc] initWithFrame:CGRectMake(0,234,57,200)];
    UIBlurEffect *playerViewBlurEffect = 0;
    playerViewBlurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    UIVisualEffectView *playerViewBlurEffectView = [[UIVisualEffectView alloc] initWithEffect:playerViewBlurEffect];
    [playerViewBlurEffectView setFrame:playerView.bounds];
    [playerView addSubview:playerViewBlurEffectView];

    playerArtwork = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 57, 57)];
    playerArtwork.userInteractionEnabled = YES;
    [playerView addSubview:playerArtwork];

    UITapGestureRecognizer *openNowPlayingViewTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(openNowPlayingView)];
    openNowPlayingViewTap.numberOfTapsRequired = 1;
    [playerArtwork addGestureRecognizer:openNowPlayingViewTap];

    playPauseButton = [[RSPlayPauseButton alloc] initWithFrame:CGRectMake(20, playerWidth * 1.5, 50, 50)];
    playPauseButton.tintColor = [UIColor whiteColor];
    [playPauseButton addTarget:self action:@selector(playPauseButtonDidPress:) forControlEvents:UIControlEventTouchUpInside];
    [playerView addSubview:playPauseButton];

    MPUMediaControlsVolumeView *volumeView = [[MPUMediaControlsVolumeView alloc] initWithStyle:2];
    volumeView.frame = CGRectMake(-20, 170, 150, 50);
    volumeView.backgroundColor = [UIColor clearColor];
    CGAffineTransform transform = CGAffineTransformRotate(CGAffineTransformIdentity, DEGREES_TO_RADIANS(-90));
    volumeView.transform = transform;
    volumeSlider = volumeView.slider;
    volumeSlider.maximumValueImage = nil;
    volumeSlider.minimumValueImage = nil;
    [playerView addSubview:volumeView];

    nowPlayingView = [[UIView alloc] initWithFrame:CGRectMake(50, 208, 155, 251)];
    nowPlayingView.alpha = 0.0;
    nowPlayingView.layer.cornerRadius = 5;
    nowPlayingView.layer.masksToBounds = YES;
    UIBlurEffect *nowPlayingViewBlurEffect = 0;
    nowPlayingViewBlurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    UIVisualEffectView *nowPlayingViewBlurEffectView = [[UIVisualEffectView alloc] initWithEffect:nowPlayingViewBlurEffect];
    [nowPlayingViewBlurEffectView setFrame:nowPlayingView.bounds];
    [nowPlayingView addSubview:nowPlayingViewBlurEffectView];

    titleLabel = [[CBAutoScrollLabel alloc] initWithFrame:CGRectMake(22.5, 250, 175, 20)];
        titleLabel.labelSpacing = 30;
        titleLabel.pauseInterval = 3;
        titleLabel.scrollSpeed = 7;
        titleLabel.fadeLength = 5.f;
        titleLabel.scrollDirection = CBAutoScrollDirectionLeft;
        titleLabel.font = [titleLabel.font fontWithSize:20];
        titleLabel.textColor = [UIColor whiteColor];
        [nowPlayingView addSubview:titleLabel];

    artistLabel = [[CBAutoScrollLabel alloc] initWithFrame:CGRectMake(22.5, 300, 175, 20)];
        artistLabel.labelSpacing = 30;
        artistLabel.pauseInterval = 3;
        artistLabel.scrollSpeed = 7;
        artistLabel.fadeLength = 5.f;
        artistLabel.scrollDirection = CBAutoScrollDirectionLeft;
        artistLabel.font = [artistLabel.font fontWithSize:15];
        artistLabel.textColor = [UIColor whiteColor];
        [nowPlayingView addSubview:artistLabel];

    trackProgressView = [[MPUChronologicalProgressView alloc] initWithStyle:2];
          trackProgressView.bounds = CGRectMake(0, 0, playerWidth * 2.71, 10);
          trackProgressView.layer.position = CGPointMake(110, 230);
    delegate = MSHookIvar<id>(self, "_delegate");
    trackProgressView.delegate = (id)self;
          [nowPlayingView addSubview:trackProgressView];

          [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateVolume:) name:@"AVSystemController_SystemVolumeDidChangeNotification" object:nil];
      		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateMedia) name:(__bridge NSString *)kMRMediaRemoteNowPlayingInfoDidChangeNotification object:nil];

  }
  return self;
}

- (void)openNowPlayingView {
	if (nowPlayingView.alpha == 0.0) {
        [UIView animateWithDuration:0.3f animations:^{
            nowPlayingView.alpha = 1.0;
        }];
    } else {
        [UIView animateWithDuration:0.3f animations:^{
            nowPlayingView.alpha = 0.0;
        }];
    }
}

- (void)playPauseButtonDidPress:(RSPlayPauseButton *)playPauseButton {
    MRMediaRemoteSendCommand(kMRTogglePlayPause, nil);
}

- (void)updateVolume:(NSNotification *)notification {
  volumeSlider.value = [notification.userInfo[@"AVSystemController_AudioVolumeNotificationParameter"] floatValue];
}

@end
