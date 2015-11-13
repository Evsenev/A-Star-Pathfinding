#import <Foundation/Foundation.h>
#import "AppDelegate.h"

@interface Pathfinder : NSObject {
    @private Node *start, *finish;
}
@property NSMutableArray *openedNodes;
-(void)findPathFrom:(Node *)from toNode:(Node *)to;
-(void)clear;
+(instancetype) sharedInstance;
@end
