#import "NodePosition.h"

@implementation NodePosition
+(NodePosition *) createNodePositionWithX:(int)x andY:(int)y {
    NodePosition * result = [[NodePosition alloc] init];
    result.x = x;
    result.y = y;
    return result;
}
@end
