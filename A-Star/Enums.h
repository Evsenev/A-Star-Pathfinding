typedef enum {
    PathPart,
    StartNode,
    EndNode,
    BlockNode,
    SimpleNode,
    OpenedNode
} State;

typedef enum {
    SetupStart,
    SetupEnd,
    SetupBlock
} Tool;