package pathfinding 
{
	import com.uselessworks.Vector2;
	import net.flashpunk.FP;
	/**
	 * ...
	 * @author Rémi Bismuth @uselessworks.com
	 */
	public class Pathfinder 
	{
		private static var _closedList:Vector.<Vector.<Node>>
		private static var _openList:Vector.<Vector.<Node>>
		private static var _sortedOpenList:Vector.<Node>
		
		private static var _graph:Vector.<Vector.<Node>>
		public static function get graph():Vector.<Vector.<Node>> { return _graph }
		public static function set graph(value:Vector.<Vector.<Node>>):void {
			_graph = value;
		}
		
		private static function _clearLists():void {
			var graphWidth:int = _graph.length;
			var graphHeight:int = _graph[0].length;
			
			_openList = new Vector.<Vector.<Node>>(graphWidth);
			_closedList = new Vector.<Vector.<Node>>(graphWidth);
			for (var i:int = 0; i < graphWidth; i++) {
				_openList[i] = new Vector.<Node>(graphHeight);
				_closedList[i] = new Vector.<Node>(graphHeight);
			}
			
			_sortedOpenList = new Vector.<Node>
		}
		
		// heuristic function : here we use manhattan distance heuristic
		private static function _h(node:Node, target:Node):Number {
			var D:Number = 1;
			var dx:int = Math.abs(node.x - target.x);
			var dy:int = Math.abs(node.y - target.y);
			return D * (dx + dy);
		}
	
		public static function findPath(start:Vector2, target:Vector2):Vector.<Node> {
			var path:Vector.<Node>;
			// Check if start and target exists
			var startNode:Node = _graph[start.x][start.y];
			var targetNode:Node = _graph[target.x][target.y];
			if (startNode && targetNode) {
				_clearLists();
				// Init startNode
				startNode.g = 0;
				startNode.h = _h(startNode, targetNode);
				startNode.parent = null;
				_sortedOpenList.push(startNode);
				_openList[startNode.x][startNode.y] = startNode;
				// While target isn't reached and target is still reachable
				while (_sortedOpenList.length > 0 && _sortedOpenList[0] != targetNode) {
					// Select most probable node
					var currentNode:Node = _sortedOpenList[0];
					// Remove node from open list
					_sortedOpenList.splice(0, 1);
					_openList[currentNode.x][currentNode.y] = null;
					// Add node to closed list
					_closedList[currentNode.x][currentNode.y] = currentNode;
					// Get node neighbors
					var neighbors:Vector.<Node> = _getNeighbors(currentNode);
					for each (var neighbor:Node in neighbors) {
						var cost:Number = currentNode.g + neighbor.cost;
						var h:Number = _h(neighbor, targetNode)
						
						
						// If neighbor is already in Open list but is a better path, remove it from Open list
						var i:int = _sortedOpenList.lastIndexOf(neighbor);
						
						if (i != -1 && cost + h < _sortedOpenList[i].f) {
							_sortedOpenList.splice(i, 1);
							_openList[neighbor.x][neighbor.y] = null;
						}
						
						// If neighbor is already in Closed list but is a better path, remove it from Open list
						if (_closedList[neighbor.x][neighbor.y] && cost + h < _closedList[neighbor.x][neighbor.y].f) {
							_closedList[neighbor.x][neighbor.y] = null;
						}
						
						// Then if neighbor is finally not in Open and Closed list
						if (!_closedList[neighbor.x][neighbor.y] && !_openList[neighbor.x][neighbor.y]) {
							neighbor.g = cost;
							neighbor.h = _h(neighbor, targetNode);
							neighbor.parent = currentNode;
							_sortedOpenList.push(neighbor);
							_openList[neighbor.x][neighbor.y] = neighbor;
							_sortOpenList();
						}
					}
				}
				
				if (_sortedOpenList.length > 0) {
					
					path = new Vector.<Node>;
					
					var winner:Node = _sortedOpenList[0];
					
					while (winner) {
						path.push(winner);
						winner = winner.parent;
					}
					path = path.reverse();
				}
			}
			return path;
		}
		
		private static function _getNeighbors(node:Node):Vector.<Node> {
			var neighbors:Vector.<Node> = new Vector.<Node>;
			if (node.x > 0 && _graph[node.x - 1][node.y] != null) {
				neighbors.push(_graph[node.x - 1][node.y]);
			}
			if (node.y > 0 && _graph[node.x][node.y - 1] != null) {
				neighbors.push(_graph[node.x][node.y - 1]);
			}
			if (node.x < _graph.length - 1 && _graph[node.x + 1][node.y] != null) {
				neighbors.push(_graph[node.x + 1][node.y]);
			}
			if (node.y < _graph[0].length - 1 && _graph[node.x][node.y + 1] != null) {
				neighbors.push(_graph[node.x][node.y + 1]);
			}
			return neighbors;
			
		}

		
		private static function _sortOpenList():void {
			_sortedOpenList = _sortedOpenList.sort(function(a:Node, b:Node):int {
				var sign:int = a.f - b.f;
				sign = sign == 0 ? 0 : sign / Math.abs(sign);
				return sign;
			});
		}
		
	}

}