#import "ZBMainViewController.h"

@interface ZBMainViewController ()
{
	CTTelephonyNetworkInfo *info;
}
- (void)updateCarrierInfo;
@end

@implementation ZBMainViewController

- (void)viewDidLoad
{
	[super viewDidLoad];
	__block ZBMainViewController *this = self;
	if (!info) {
		info = [[CTTelephonyNetworkInfo alloc] init];
		info.subscriberCellularProviderDidUpdateNotifier = ^(CTCarrier *carrier) {
			[this updateCarrierInfo];
		};
	}
	[self updateCarrierInfo];
}

- (void)didReceiveMemoryWarning
{
	[super didReceiveMemoryWarning];
}

- (void)updateCarrierInfo
{
	if (![self isViewLoaded]) {
		return;
	}
	CTCarrier *carrier = info.subscriberCellularProvider;
#define HAS_LENGTH(x) ([x length] ? x : NSLocalizedString(@"N/A", @""))
	if (carrier) {
		NSString *message = [NSString stringWithFormat: NSLocalizedString(@"Carrier Name: %@\nCountry Code: %@\nNetwork Code: %@\nISO Country Code: %@", @""), HAS_LENGTH(carrier.carrierName),
							 HAS_LENGTH(carrier.mobileCountryCode),
							 HAS_LENGTH(carrier.mobileNetworkCode),
							 HAS_LENGTH(carrier.isoCountryCode)];
		messageLabel.text = message;
#undef HAS_LENGTH
	}
	else {
		messageLabel.text = NSLocalizedString(@"No carrier information available.", @"");
	}
}

- (IBAction)mail:(id)sender
{
	if (![MFMailComposeViewController canSendMail]) {
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"You cannot send mails right now.", @"") message:@"" delegate:nil cancelButtonTitle:NSLocalizedString(@"Dismiss", @"") otherButtonTitles:nil];
		[alert show];
		return;
	}
	CALayer *layer = self.view.layer;
	UIGraphicsBeginImageContext(self.view.bounds.size);
	CGContextRef ctx = UIGraphicsGetCurrentContext();
	[layer renderInContext:ctx];
	UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();

	MFMailComposeViewController *composer = [[MFMailComposeViewController alloc] init];
	[composer addAttachmentData:UIImagePNGRepresentation(image) mimeType:@"image/png" fileName:@"info.png"];
	composer.mailComposeDelegate = self;
	[composer setSubject:NSLocalizedString(@"Telephony information", @"")];
	[composer setMessageBody:NSLocalizedString(@"The image file is attached.", @"") isHTML:NO];
	composer.navigationBar.barStyle = UIBarStyleBlackOpaque;
	[self presentViewController:composer animated:YES completion:nil];
}

#pragma mark - MFMailComposeViewControllerDelegate

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
	[self dismissViewControllerAnimated:YES completion:^{
		NSString *message = nil;
		switch (result) {
//			case MFMailComposeResultCancelled:
//				message = NSLocalizedString(@"Mail cancelled..", @"");
//				break;
//			case MFMailComposeResultSaved:
//				message = NSLocalizedString(@"Mail saved.", @"");
//				break;
			case MFMailComposeResultSent:
				message = NSLocalizedString(@"Mail sent.", @"");
				break;
			case MFMailComposeResultFailed:
				message = NSLocalizedString(@"Failed to sent mail..", @"");
				break;
			default:
				break;
		}
		if (message) {
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:message message:@"" delegate:nil cancelButtonTitle:NSLocalizedString(@"Dismiss", @"") otherButtonTitles:nil];
			[alert show];
		}
	}];
}

#pragma mark - Flipside View

- (void)flipsideViewControllerDidFinish:(ZBFlipsideViewController *)controller
{
	[self dismissViewControllerAnimated:YES completion:nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
	if ([[segue identifier] isEqualToString:@"showAlternate"]) {
		[[segue destinationViewController] setDelegate:self];
	}
}

@synthesize messageLabel;

@end
