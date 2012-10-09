#import "Application.h"
#import "Controller.h"
#import "FISound.h"

//#import "SHK.h"
//#import "SHKFacebook.h"
//#import "SHKTwitter.h"
//#import "SHKMail.h"

#import "Chartboost.h"

@implementation Controller
@synthesize sitarSound, gunSound;
- (IBAction) playSitarSound
{
    Application *app = (Application *) [UIApplication sharedApplication].delegate;
    [app setRandomSound];
    [sitarSound play];
}

- (IBAction)btnMore:(id)sender {
    
    [[Chartboost sharedChartboost] showMoreApps];

}

- (IBAction)btnTwitter:(id)sender {
}

- (IBAction)btnFacebook:(id)sender {
}

- (IBAction)btnMail:(id)sender {
}

- (IBAction) playGunSound
{
    for (int i=0; i<4; i++) {
        [gunSound play];
        usleep(80000);
    }
}

- (IBAction) updateSoundPitchFrom: (UISlider*) slider
{
    sitarSound.pitch = gunSound.pitch = slider.value;
}


- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    if ( event.subtype == UIEventSubtypeMotionShake )
    {
        // Put in code here to handle shake
        [self playSitarSound];
    }
    
    if ( [super respondsToSelector:@selector(motionEnded:withEvent:)] )
        [super motionEnded:motion withEvent:event];
}
- (void) viewWillAppear:(BOOL)animated
{
    [self.view becomeFirstResponder];
    [super viewWillAppear:animated];
    
}
-(void)viewDidAppear:(BOOL)animated{
    [self becomeFirstResponder];
    [self.view becomeFirstResponder];
    [super viewDidAppear:animated];
}
- (void) viewWillDisappear:(BOOL)animated
{
    [self.view resignFirstResponder];
    [super viewWillDisappear:animated];
}
- (void)viewDidUnload 
{ 

}

- (BOOL)canBecomeFirstResponder
{ return YES; }


@end