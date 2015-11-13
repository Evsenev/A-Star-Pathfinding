#import "AppDelegate.h"

@interface  NodePosition : NSObject
@property int x;
@property int y;
+(NodePosition *) createNodePositionWithX:(int)x andY:(int)y;
@end


