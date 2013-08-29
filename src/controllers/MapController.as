package controllers 
{
	import entities.Unit;
	import data.Balance;
	import level.Tile;
	/**
	 * ...
	 * @author Rémi Bismuth @uselessworks.com
	 */
	public class MapController 
	{
		private static var _unitsMap:Vector.<Vector.<Vector.<Unit>>>
		public static var map:Vector.<Vector.<Tile>>;
		
		public static function init():void {
			// CREATE UNITS MAP VECTOR
			_unitsMap = new Vector.<Vector.<Vector.<Unit>>>(Balance.TIME_RANGE + 1);
			var i:int;
			for (i = 0; i < Balance.TIME_RANGE + 1; i++ ) {
				_unitsMap[i] = new Vector.<Vector.<Unit>>(map.length);
				
				for (var j:int = 0; j < map.length; j++) {
					_unitsMap[i][j] = new Vector.<Unit>(map[0].length);
				}
			}
			
			Events.onUnitAdded.add(function(unit:Unit):void {
				_buildAllUnitsMaps();
			});
			
			Events.onUnitMoved.add(function(unit:Unit):void {
				_buildAllUnitsMaps(); // TODO: OPTIMIZE
			});
		}
		
		private static function _buildUnitsMapAt(time:int):void {
			_clearUnitsMapAt(time);
			for each (var unit:Unit in Game.unitsList) {
				var position:Tile = unit.getPositionAt(time);
				_unitsMap[time][position.x][position.y] = unit;
			}
		}
		
		private static function _buildAllUnitsMaps():void {
			for (var time:int = 0; time < _unitsMap.length; time++) {
				_buildUnitsMapAt(time);
			}
		}
		
		private static function _clearUnitsMapAt(time:int):void {
			// PREPARE ENTITIES AND MOVEMENT MAP
			var x:int;
			for (x = 0; x < _unitsMap[time].length; x++ ) {
				for (var y:int = 0; y < _unitsMap[time][x].length; y++) {
					_unitsMap[time][x][y] = null;
				}
			}
		}
		
		private static function _clearAllUnitsMaps():void {
			for (var time:int = 0; time < _unitsMap.length; time++) {
				_clearUnitsMapAt(time);
			}
		}
		
		public static function getTileAt(x:int, y:int):Tile {
			if (x >= 0 && x < map.length && y >= 0 && y < map[0].length) {
				return map[x][y];
			} else {
				return null
			}
		}
		
		public static function getUnitAt(x:int, y:int, time:int):Unit {
			return _unitsMap[time][x][y];
		}
		
		/*public function globalToTileCoordinates(x:int, y:int):Vector2 {
			return new Vector2(Math.floor(x / Game.tileWidth), Math.floor(y / Game.tileHeight));
		}
		
		public function getTerrainAtMousePosition():TerrainTile {
			var t:Vector2 = new Vector2(Math.floor(mouseX / Game.tileWidth), Math.floor(mouseY / Game.tileHeight));
			return getTerrainAt(t.x, t.y);
		}*/
	}

}