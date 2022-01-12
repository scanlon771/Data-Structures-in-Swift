//Graph Algorithms
//Breadth-First Search (BFS)
//Implementation
public class BFSNode<T> {
    public var nodeValue: T
    public var nodeNeighbors: [BFSNode]
    public var visitedNode: Bool
    public init(value: T, neighbors: [BFSNode], visited: Bool) {
        self.nodeValue = value
        self.nodeNeighbors = neighbors
        self.visitedNode = visited
    }
    public func addNeighbor(node: BFSNode) {
        self.nodeNeighbors.append(node)
        node.nodeNeighbors.append(self)
    }
    
    public static func breadthFirstSearch(first: BFSNode) {
        var queue: [BFSNode] = []
        queue.append(first)
        while queue.isEmpty == false {
            if let node = queue.first {
                print(node.nodeValue)
                node.visitedNode = true
                for child in node.nodeNeighbors {
                    if child.visitedNode == false {
                        queue.append(child)
                    }
                }
                queue.removeFirst()
            }
        }
    }
}

let nodeA = BFSNode(value: "A", neighbors: [], visited: false)
let nodeB = BFSNode(value: "B", neighbors: [], visited: false)
let nodeC = BFSNode(value: "C", neighbors: [], visited: false)
let nodeD = BFSNode(value: "D", neighbors: [], visited: false)
let nodeE = BFSNode(value: "E", neighbors: [], visited: false)
let nodeF = BFSNode(value: "F", neighbors: [], visited: false)
nodeA.addNeighbor(node: nodeB)
nodeC.addNeighbor(node: nodeB)
nodeD.addNeighbor(node: nodeB)
nodeE.addNeighbor(node: nodeB)
nodeF.addNeighbor(node: nodeD)
BFSNode.breadthFirstSearch(first: nodeA)
//Output
"A"
"B"
"C"
"D"
"E"
"F"

//Depth-First Search (DFS)
//Implementation
public class DFNode<inputType> {
    public var value: inputType
    public var children: [DFNode] = []
    public init(_ value: inputType) {
        self.value = value
    }
    public func addChild(_ child: DFNode) {
        children.append(child)
    }
    
    public func depthFirstSearch(visit: (DFNode) -> Void) {
        visit(self)
        children.forEach {
            $0.depthFirstSearch(visit: visit)
        }
    }
}
let nodeA2 = DFNode("A")
let nodeB2 = DFNode("B")
let nodeC2 = DFNode("C")
let nodeD2 = DFNode("D")
let nodeE2 = DFNode("E")
let nodeF2 = DFNode("F")
let nodeG2 = DFNode("G")
nodeA2.addChild(nodeB2)
nodeA2.addChild(nodeC2)
nodeB2.addChild(nodeE2)
nodeB2.addChild(nodeF2)
nodeE2.addChild(nodeG2)
nodeA2.depthFirstSearch {
    print($0.value)
}
//Output
"A"
"B"
"E"
"G"
"F"
"C"

//Dijkstra's Algorithm
//Implementation
class GraphNode {
    var visited = false
    var connections: [Connection] = []
}

class Connection {
    public let toNode: GraphNode
    public let cost: Int
    public init(to node: GraphNode, cost: Int) {
        assert(cost >= 0, "Cost has to be equal or greater than zero")
        self.toNode = node
        self.cost = cost
    }
}

class Path {
    public let cumulativeCost: Int
    public let node: GraphNode
    public let previousPath: Path?
    init(to node: GraphNode, via connection: Connection? = nil, previousPath path: Path? = nil) {
        if let previousPath = path, let viaConnection = connection {
            self.cumulativeCost = viaConnection.cost + previousPath.cumulativeCost
        } else {
            self.cumulativeCost = 0
        }
        self.node = node
        self.previousPath = path
    }
}

func dijskastraShortestPath(source: GraphNode, destination: GraphNode) -> Path? {
    var pathCollection: [Path] = [] {
        didSet {
            pathCollection.sort { return $0.cumulativeCost < $1.cumulativeCost }
        }
    }
    pathCollection.append(Path(to: source))
    while !pathCollection.isEmpty {
        let cheapestPathInPathCollection = pathCollection.removeFirst()
        guard !cheapestPathInPathCollection.node.visited else {
            continue
        }
        if cheapestPathInPathCollection.node === destination {
            return cheapestPathInPathCollection
        }
        cheapestPathInPathCollection.node.visited = true
        for connection in cheapestPathInPathCollection.node.connections where !connection.toNode.visited {
            pathCollection.append(Path(to: connection.toNode, via: connection, previousPath: cheapestPathInPathCollection))
        }
    }
    return nil
}

class sampleGraphNode: GraphNode {
    let name: String
    init(name: String) {
        self.name = name
        super.init()
    }
}

let nodeA3 = sampleGraphNode(name: "A")
let nodeB3 = sampleGraphNode(name: "B")
let nodeC3 = sampleGraphNode(name: "C")
let nodeD3 = sampleGraphNode(name: "D")
let nodeE3 = sampleGraphNode(name: "E")
let nodeF3 = sampleGraphNode(name: "F")
let nodeG3 = sampleGraphNode(name: "G")
nodeA3.connections.append(Connection(to: nodeB3, cost: 2))
nodeA3.connections.append(Connection(to: nodeC3, cost: 5))
nodeB3.connections.append(Connection(to: nodeC3, cost: 6))
nodeB3.connections.append(Connection(to: nodeD3, cost: 1))
nodeB3.connections.append(Connection(to: nodeE3, cost: 3))
nodeC3.connections.append(Connection(to: nodeF3, cost: 8))
nodeD3.connections.append(Connection(to: nodeE3, cost: 4))
nodeE3.connections.append(Connection(to: nodeG3, cost: 9))
nodeF3.connections.append(Connection(to: nodeG3, cost: 7))
let sourceNode = nodeA3
let destinationNode = nodeG3
var path = dijskastraShortestPath(source: sourceNode, destination: destinationNode)
if let succession: [String] = path?.array.reversed().compactMap({ $0 as? sampleGraphNode}).map({$0.name}) {
  print("Quickest path: \(succession)")
} else {
    print("No path between \(sourceNode.name) & \(destinationNode.name)")
}
//Output
"Quickest path: ['A', 'B', 'E', 'G']"
