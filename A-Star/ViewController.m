//
//  ViewController.m
//  A-Star
//
//  Created by Богдан on 07.11.15.
//  Copyright © 2015 Богдан. All rights reserved.
//


#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

const float TOP_OFFSET = 20;
const int NODE_DISTANCE = 5;
const int NODE_SIZE = 30;
const int TOOLBAR_HEIGHT = 45;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadField];
}

-(void)loadField {
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    CGFloat screenHeight = screenRect.size.height;
    
    int xCount = screenWidth / (NODE_SIZE + NODE_DISTANCE);
    int yCount = (screenHeight - TOOLBAR_HEIGHT)/ (NODE_SIZE + NODE_DISTANCE) ;
    
    
    for (int i = 0; i < xCount; i++) {
        float xOffset = i * (NODE_SIZE + NODE_DISTANCE) + NODE_DISTANCE;
        if(i == 0) xOffset = NODE_DISTANCE;
        
        for (int j = 0; j < yCount; j++) {
            float yOffset  = j * (NODE_SIZE + NODE_DISTANCE) + TOP_OFFSET;
            if(j == 0) yOffset = TOP_OFFSET;
            
            Node *node = [[Node alloc] initWithFrame:CGRectMake(xOffset, yOffset,
                                                                NODE_SIZE, NODE_SIZE)];
            [node setX:i andY:j];
            [self.view addSubview:node];
            if(!appDelegate.nodes)
                appDelegate.nodes = [[NSMutableArray alloc] init];
            [appDelegate.nodes addObject:node];
        }
    }
}

- (IBAction)onToolSwitch:(id)sender {
    UISegmentedControl *segmentControl = (UISegmentedControl *)sender;
    appDelegate.tool = segmentControl.selectedSegmentIndex;
}

-(void)onClearClick:(id)sender {
    for(Node *node in appDelegate.nodes)
        [node setState:SimpleNode];
    [[Pathfinder sharedInstance] clear];
}

-(void)onFindClick:(id)sender {
    [[Pathfinder sharedInstance] findPathFrom:appDelegate.startNode toNode:appDelegate.endNode];
}

@end
