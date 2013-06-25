@class ZBFlipsideViewController;

@protocol ZBFlipsideViewControllerDelegate
- (void)flipsideViewControllerDidFinish:(ZBFlipsideViewController *)controller;
@end

@interface ZBFlipsideViewController : UIViewController

@property (weak, nonatomic) id <ZBFlipsideViewControllerDelegate> delegate;

- (IBAction)done:(id)sender;

@end
