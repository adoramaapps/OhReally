#import "Application.h"
#import "Controller.h"
#import "FISoundEngine.h"
#import "FIFactory.h"
#import "iRate.h"

#import <RevMobAds/RevMobAds.h>

#import "FlurryAnalytics.h"

#import "PushNotificationManager.h"

#import "Chartboost.h"

@interface Application ()
@property(strong) FIFactory *soundFactory;
@property(strong) FISoundEngine *soundEngine;
@end

@implementation Application
@synthesize window, controller, soundFactory, soundEngine;

- (void) onPushAccepted:(PushNotificationManager *)pushManager withNotification:(NSDictionary *)pushNotification {
    NSLog(@"Push notification received");
}

+ (void)initialize
{
    //configure iRate
    [iRate sharedInstance].daysUntilPrompt = 1;
    [iRate sharedInstance].usesUntilPrompt = 2;
}

- (void) applicationDidFinishLaunching: (UIApplication*) application
{
    
    // collect your AppID at http://revmob.com
    [RevMobAds startSessionWithAppID:@"505b8e463c43970c00000001"];
    
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    
    [FlurryAnalytics startSession:@"P74Q7CNNGTGNR3KZ6DXT"];
    
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];
    soundFactory = [[FIFactory alloc] init];
    [soundFactory setLogger:FILoggerNSLog];

    [self setSoundEngine:[soundFactory buildSoundEngine]];
    [soundEngine activateAudioSessionWithCategory:AVAudioSessionCategoryPlayback];
    [soundEngine openAudioDevice];

    int no =rand() % (40- 1)+1;
    NSLog(@"No : %d",no);
    NSString *filename = [NSString stringWithFormat:@"%d.wav",no];
//    NSString *soundPath = [[NSBundle mainBundle] pathForResource:filename ofType:@"wav"];

    [controller setSitarSound:[soundFactory loadSoundNamed:filename error:NULL]];    
    
//    [controller setSitarSound:[soundFactory loadSoundNamed:@"sitar.wav" error:NULL]];
    [controller setGunSound:[soundFactory loadSoundNamed:@"shot.wav" maxPolyphony:4 error:NULL]];

    [window setRootViewController:controller];
    [window makeKeyAndVisible];
    
}
-(void)setRandomSound{
    int no =rand() % (40- 1)+1;
    NSLog(@"No : %d",no);
    NSString *filename = [NSString stringWithFormat:@"%d.wav",no];
    //    NSString *soundPath = [[NSBundle mainBundle] pathForResource:filename ofType:@"wav"];
    
    [controller setSitarSound:[soundFactory loadSoundNamed:filename error:NULL]];    
    
}
- (void)applicationDidBecomeActive:(UIApplication *)application {
    
    // Configure Chartboost
    Chartboost *cb = [Chartboost sharedChartboost]; cb.appId = @"5070836016ba47b81d00007d";
    cb.appSignature = @"5e8fd8bf79284cd60f3f24fe6e5f960ab421c2cf";
    // Notify the beginning of a user session
    [cb startSession];
    
    [cb cacheMoreApps];
    
    [RevMobAds showFullscreenAd];
    
    [RevMobAds showBannerAdWithDelegate:nil];    
}

@end
