#import <UIKit/UIKit.h>
#import "Node.h"
#import "Enums.h"
#import "NodePosition.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>
@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) NSMutableArray *nodes;
@property (readonly) NSArray *neighborsPositions;
@property (weak, nonatomic) Node *startNode, *endNode;
@property Tool tool;

-(Node *)getNodeWithX:(int)x andY:(int)y;
@end

