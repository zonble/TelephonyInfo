#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <CoreTelephony/CTCarrier.h>
#import <MessageUI/MessageUI.h>
#import <QuartzCore/QuartzCore.h>
#import "ZBFlipsideViewController.h"

@interface ZBMainViewController : UIViewController <ZBFlipsideViewControllerDelegate, MFMailComposeViewControllerDelegate>

- (IBAction)mail:(id)sender;

@property (strong, nonatomic) IBOutlet UILabel *messageLabel;

@end
