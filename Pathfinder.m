#import "Pathfinder.h"

@implementation Pathfinder
static Pathfinder *sharedInstance = nil;

+(instancetype)sharedInstance {
    if(!sharedInstance)
        sharedInstance = [[Pathfinder alloc] init];
    return sharedInstance;
}

-(void)findPathFrom:(Node *)from toNode:(Node *)to {
    start = from;
    finish = to;
    _openedNodes = [[NSMutableArray alloc] initWithObjects:start, nil];
    Node *current = start;
    while (current != finish) {
        current = [self openNextNode:current];
        if(!current) {
            current = [self findBestForStartFrom:start];
            [_openedNodes addObject:current];
        }
    }
    [self buildPath];
}

-(void)buildPath {
    NSMutableArray *pathNodes = [[NSMutableArray alloc] init];
    Node *current = finish;
    while (current != start) {
        [pathNodes addObject:current];
        NSMutableArray *openedNeighbours = [[NSMutableArray alloc] init];
        for(Node *node in [current getNeighbors]) {
            if(node == start){
                current = start;
                break;
            }
            if(![self isClosedNode:node] && ![pathNodes containsObject:node])
                [openedNeighbours addObject:node];
        }
        if(current == start)
            break;
        Node *bestNeighbour = openedNeighbours[0];
        for (Node *neighbour in openedNeighbours) {
            if([neighbour distanceTo:start] < [bestNeighbour distanceTo:start])
                bestNeighbour = neighbour;
        }
        current = bestNeighbour;
    }
    for (Node *openedNode in _openedNodes){
        if(openedNode == start || openedNode == finish)
            continue;
        [openedNode setState:OpenedNode];
    }
    for (Node *pathNode in pathNodes){
        if(pathNode == start || pathNode == finish)
            continue;
        [pathNode setState:PathPart];
    }
}

-(Node *)findBestForStartFrom:(Node *)node {
    Node *result = nil;
    NSMutableArray *nodesForFilter = [[NSMutableArray alloc] init];
    NSMutableArray *closedNodes = [[NSMutableArray alloc] init];
    [nodesForFilter addObjectsFromArray:[node getNeighbors]];
    while (closedNodes.count == 0) {
        NSMutableArray *nodesForAdd = [[NSMutableArray alloc] init];
        for(Node *nodeForFilter in nodesForFilter){
            Node *bestNeighbour = nil;
            bestNeighbour = [self bestNeighborOfNode:nodeForFilter amongClosed:YES];
            if(!bestNeighbour)
                [nodesForAdd addObjectsFromArray:[nodeForFilter getNeighbors]];
            else
                [closedNodes addObject:bestNeighbour];
        }
        [nodesForFilter removeAllObjects];
        [nodesForFilter addObjectsFromArray:nodesForAdd];
        
    }
    result = closedNodes[0];
    for(Node *closedNode in closedNodes)
        if([closedNode distanceTo:finish] < [result distanceTo:finish])
            result = closedNode;
    
    return result;
}

-(Node *)openNextNode:(Node *)node{
    Node *bestNeighbor = [self bestNeighborOfNode:node amongClosed:YES];
    if(bestNeighbor){
        [_openedNodes addObject:bestNeighbor];
        return bestNeighbor;
    }
    else
        return nil;
}

-(Node *)bestNeighborOfNode:(Node *)ofNode amongClosed:(BOOL)amongClosed {
    Node *result = nil;
    
    if(amongClosed){
        for(Node *node in [ofNode getNeighbors]) {
            if ([self isClosedNode:node] && node.nodeState != BlockNode)
                result = node;
        }
        if(!result)
            return nil;
    } else {
        for(Node *node in [ofNode getNeighbors])
            if(node.nodeState != BlockNode)
                result = node;
    }
    
    for(Node *node in [ofNode getNeighbors])
    {
        if(amongClosed){
            if([node distanceTo:finish] < [result distanceTo:finish] && [self isClosedNode:node]
                                                                     && node.nodeState != BlockNode)
                result = node;
        } else {
            if([node distanceTo:finish] < [result distanceTo:finish] && node.nodeState != BlockNode)
                result = node;
        }
    }
    return result;
}

-(BOOL)isClosedNode:(Node *)node{
    return ![_openedNodes containsObject:node];
}

-(void)clear {
    _openedNodes = [[NSMutableArray alloc] init];
}
@end
