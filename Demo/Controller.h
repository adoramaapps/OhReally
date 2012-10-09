@class FISound, FIRevolverSound;

@interface Controller : UIViewController
{
}
@property(strong) FISound *sitarSound;
@property(strong) FISound *gunSound;

- (IBAction) playSitarSound;
- (IBAction)btnMore:(id)sender;
- (IBAction)btnTwitter:(id)sender;
- (IBAction)btnFacebook:(id)sender;
- (IBAction)btnMail:(id)sender;

@end

