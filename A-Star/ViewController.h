#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "Pathfinder.h"


@interface ViewController : UIViewController {
@private AppDelegate *appDelegate;
}
- (IBAction)onClearClick:(id)sender;
- (IBAction)onFindClick:(id)sender;
- (IBAction)onToolSwitch:(id)sender;
@end

