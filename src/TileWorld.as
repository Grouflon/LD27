package  
{
	import controllers.MapController;
	import entities.Unit;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Tilemap;
	import net.flashpunk.World;
	import net.flashpunk.FP;
	import com.uselessworks.CommonTools;
	import com.uselessworks.Vector2;
	import data.Assets;
	import pathfinding.Node;
	import pathfinding.Pathfinder;
	
	/**
	 * ...
	 * @author Rémi Bismuth @uselessworks.com
	 */
	public class TileWorld extends World 
	{
		private var _levelData:XML;
		/*private var _terrain:Vector.<TerrainTile> = new Vector.<TerrainTile>;
		private var _terrainMap:Vector.<Vector.<TerrainTile>> = new Vector.<Vector.<TerrainTile>>*/
		
		private var _terrainEntity:Entity;
		
		
		public function TileWorld(data:Class) 
		{
			_levelData = CommonTools.parseXML(data);
		}
		
		override public function begin():void {
			Game.level = this;
			
			// EVENTS
			/*Events.onUnitAdded.add(_onUnitAdded);
			Events.onUnitMoved.add(_onUnitMoved);*/
			
			_extractProperties(_levelData);
			_generateTerrain(_levelData);
			
			//add(new Unit(2, 2));
			
			Events.onLevelStart.dispatch(this);
		}
		
		/*private function _onUnitAdded(tiledEntity:Unit):void {
			getTerrainAt(tiledEntity.xPosition, tiledEntity.yPosition).entity = tiledEntity;
		}
		
		private function _onUnitMoved(tiledEntity:Unit):void {
			getTerrainAt(tiledEntity.xPosition, tiledEntity.yPosition).entity = tiledEntity;
		}*/
		
		private function _extractProperties(levelData:XML):void {
			Game.tileWidth = levelData.@tilewidth;
			Game.tileHeight = levelData.@tileheight;
		}
		
		// Terrain always generated at time 0
		private function _generateTerrain(levelData:XML):void
		{
			var dataList:XMLList;
			var dataElement:XML;
			
			// GET AND SET MAP VARIABLES
			var terrainData:XMLList = levelData.layer.(@name == 'terrain');
			var entitiesData:XMLList = levelData.layer.(@name == 'entities');
			var rowsNumber:int = terrainData.@width;
			var colsNumber:int = terrainData.@height;
			var row:int = 0;
			var col:int = 0;
			var tileMap:Tilemap = new Tilemap(Assets.TILESET, Game.tileWidth * colsNumber, Game.tileHeight * rowsNumber, Game.tileWidth, Game.tileHeight);
			_terrainEntity = addGraphic(tileMap, 100);
			
			// PATHFINDER GRAPH
			//var pathfindingGraph:Vector.<Vector.<Node>> = new Vector.<Vector.<Node>>(colsNumber);
			
			// PREPARE TERRAIN MAP
			var map:Vector.<Vector.<Tile>> = new Vector.<Vector.<Tile>>(colsNumber);
			var entities:Vector.<Vector.<Unit>> = new Vector.<Vector.<Unit>>(colsNumber);
			for (var i:int = 0; i < rowsNumber; i++) {
				map[i] = new Vector.<Tile>(rowsNumber);
				entities[i] = new Vector.<Unit>(rowsNumber);
				//pathfindingGraph[i] = new Vector.<Node>(rowsNumber);
			}
			
			// BUILD MAP
			for each(dataElement in terrainData.data.tile) {
				var tileProperties:XMLList = levelData.tileset.tile.(@id == (dataElement.@gid - 1)).properties;
				var movementCost:int = tileProperties.property.(@name == "movementCost").@value;
				
				var tile:Tile = new Tile(col, row, movementCost);
				
				//var node:Node = new Node(col, row, movementCost);
				//_terrain.push(tile);
				//pathfindingGraph[col][row] = node;
				
				map[col][row] = tile;
				tileMap.setTile(col, row, dataElement.@gid - 1);
				
				if (col < rowsNumber - 1) col ++;
				else { col = 0; row++; }
			}
			
			// GENERATE ENTITIES
			col = row = 0;
			for each(dataElement in entitiesData.data.tile) {
				if (dataElement.@gid == 3) {
					entities[col][row] = (add(new Unit(col, row)) as Unit);
				}
				
				if (col < rowsNumber - 1) col ++;
				else { col = 0; row++; }
			}
			
			MapController.map = map;
			//Pathfinder.graph = pathfindingGraph;
		}
		
		override public function update():void {
			Game.update();
		}
		
		override public function render():void {
			super.render();
			Events.onRender.dispatch();
		}
		
	}

}