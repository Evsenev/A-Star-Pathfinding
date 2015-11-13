#import <UIKit/UIKit.h>
#import "Enums.h"

@interface Node : UIButton {
    @private CGContextRef context;
    @private UIColor *colorStroke, *colorFill;
}
@property (readonly) State nodeState;
@property int x, y;
@property BOOL isBlock;
-(void)setState:(State)state;
-(NSArray *)getNeighbors;
-(double)distanceTo:(Node *)toNode;
-(void)setX:(int)x andY:(int)y;

+(double)distanceFrom:(Node *)fromNode to:(Node *)toNode;

@end
