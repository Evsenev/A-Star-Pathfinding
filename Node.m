#import "AppDelegate.h"

@implementation Node

static AppDelegate *appDelegate;

-(void)drawRect:(CGRect)rect {
    if(!context)
        context = UIGraphicsGetCurrentContext();
    CGContextClearRect(context, self.bounds);

    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:8];
    path.lineWidth = 4;
    
    [colorStroke setStroke];
    [colorFill setFill];
    [path fill];
    [path stroke];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.bounds = frame;
        [self initialize];
    }
    return self;
}

-(instancetype)init {
    self = [super init];
    if(self){
        [self initialize];
    }
    return self;
}

-(void)initialize {
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    [self addTarget:self action:@selector(onNodeTap) forControlEvents:UIControlEventTouchUpInside];
    [self setState:SimpleNode];
    if(!appDelegate.nodes)
        appDelegate.nodes = [[NSMutableArray alloc] init];
    [appDelegate.nodes addObject:self];
   
}

-(void)setX:(int)x andY:(int)y {
    _x = x;
    _y = y;
    UILabel *text = [[UILabel alloc] initWithFrame:self.bounds];
    text.text = [NSString stringWithFormat:@"  %d,%d",_x,_y];
    [self addSubview:text];
    text.font = [[text font] fontWithSize:8];
}

-(void)onNodeTap {
        [self applyCurrentTool];
}

-(void)changeFillColor:(UIColor *)mainColor andBorderColor:(UIColor *)borderColor {
    
    colorFill = mainColor;
    colorStroke = borderColor;
    [self setNeedsDisplay];
}

-(void)setState:(State)state {
    switch (state) {
        case StartNode:
            [self changeFillColor:[UIColor greenColor] andBorderColor:[UIColor greenColor]];
            break;
        case EndNode:
            [self changeFillColor:[UIColor redColor] andBorderColor:[UIColor redColor]];
            break;
        case BlockNode:
            [self changeFillColor:[UIColor blackColor] andBorderColor:[UIColor grayColor]];
            _isBlock = YES;
            break;
        case PathPart:
            [self changeFillColor:[UIColor blueColor] andBorderColor:[UIColor whiteColor]];
            break;
        case OpenedNode:
            [self changeFillColor:[UIColor grayColor] andBorderColor:[UIColor grayColor]];
            break;
        case SimpleNode:
            [self changeFillColor:[UIColor whiteColor] andBorderColor:[UIColor blackColor]];
            _isBlock = NO;
        break;
    }
    _nodeState = state;
}

-(void)applyCurrentTool {
    switch (appDelegate.tool) {
        case SetupBlock:
            if(_nodeState == StartNode || _nodeState == EndNode)
                return;
            [self setState:_isBlock ? SimpleNode : BlockNode];
            break;
        case SetupEnd:
            if(_nodeState == BlockNode)
                return;
            [appDelegate.endNode setState:SimpleNode];
            appDelegate.endNode = self;
            [self setState:EndNode];
            break;
        case SetupStart:
            if(_nodeState == BlockNode)
                return;
            [appDelegate.startNode setState:SimpleNode];
            appDelegate.startNode = self;
            [self setState:StartNode];
            break;
    }
}

-(NSArray *)getNeighbors {
    NSMutableArray *result = [[NSMutableArray alloc] init];
    for(NodePosition *np in appDelegate.neighborsPositions){
        Node *node = [appDelegate getNodeWithX:self.x + np.x andY:self.y + np.y];
        if(node)
           [result addObject:node];
    }
    return result;
}

-(double)distanceTo:(Node *)toNode {
    return [Node distanceFrom:self to:toNode];
}

+(double)distanceFrom:(Node *)fromNode to:(Node *)toNode
{
    double powX = pow(toNode.x - fromNode.x, 2);
    double powY = pow(toNode.y - fromNode.y, 2);
    return sqrt(powX + powY);
}

-(void)open {
    
}

@end
