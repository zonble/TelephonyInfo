#import "ZBFlipsideViewController.h"

@interface ZBFlipsideViewController ()

@end

@implementation ZBFlipsideViewController

- (void)viewDidLoad
{
	[super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
	[super didReceiveMemoryWarning];
}

#pragma mark - Actions

- (IBAction)done:(id)sender
{
	[self.delegate flipsideViewControllerDidFinish:self];
}

@end
