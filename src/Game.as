package  
{
	import actions.Action;
	import controllers.CursorController;
	import controllers.MapController;
	import controllers.InputController;
	import controllers.SoundController;
	import controllers.MovementController;
	import controllers.TimeController;
	import entities.Cursor;
	import data.Assets;
	import data.Balance;
	import entities.Unit;
	import ui.ContextMenu;
	import net.flashpunk.World;
	import net.flashpunk.FP;
	import level.Tile;
	import level.TileWorld;
	
	/**
	 * ...
	 * @author Rémi Bismuth @uselessworks.com
	 */
	public final class Game 
	{
		public static var debug:Boolean = false;
		public static var level:TileWorld;
		public static var selectedUnit:Unit;
		
		private static var _contextMenu:ContextMenu;
		/**
		 * States of the game !
		 * idle			Default state, cursor can move and select units
		 * move			A unit is selected and is awaiting for its path to be given
		 * contextMenu	A context menu is open
		 */
		public static var state:String;
		
		// ENTITIES
		public static var cursor:Cursor;
		public static function get unitsList():Vector.<Unit> {
			var u:Vector.<Unit> = new Vector.<Unit>;
			Game.level.getClass(Unit, u);
			return u;
		}
		
		public static function get time():int { return TimeController.time }
		public static function get maxTime():int { return Balance.TIME_RANGE }
		
		//
		public static var tileWidth:int = 0;
		public static var tileHeight:int = 0;
		
		public static function init():void {
			// LEVEL
			Events.onLevelStart.add(_onLevelStart);
			
			// INPUT
			Events.onMousePressed.add(function():void {
				
			});
			Events.onMousePressedRight.add(function():void {
				
			});
			Events.onActionKeyPressed.add(function():void {
				if (state == "idle") {
					var actionsList:Vector.<Class> = getActionsAt(cursor.x, cursor.y, time);
					if (actionsList.length) {
						_openContextMenu(cursor.x, cursor.y, actionsList);
						changeState("contextMenu");
					}
				} else if (state == "contextMenu") {
					_contextMenu.executeAction();
				} else if (state == "move") {
					MovementController.applyMovement();
					selectedUnit.deselect();
				}
				
			});
			Events.onReturnKeyPressed.add(function():void {
				if (state == "move") {
					MovementController.cancelMovement();
					changeState("idle");
					selectedUnit.deselect();
				}
				
				if (state == "contextMenu") {
					_contextMenu.close();
					changeState("idle");
				}
				
			});
			Events.onTimeUpKeyPressed.add(function():void {
				if (state == "idle") {
					timeUp();
				}
			});
			Events.onTimeDownKeyPressed.add(function():void {
				if (state == "idle") {
					timeDown();
				}
			});
			
			// ACTIONS
			Events.onActionTriggered.add(function(a:Class):void {
				
			});
			
			// UNITS
			Events.onUnitSelected.add(function(e:Unit):void {
				selectedUnit = e;
			});
			Events.onUnitDeselected.add(function(e:Unit):void {
				selectedUnit = null;
			});
			
			// UI
			Events.onContextMenuOpen.add(function():void {
				cursor.canMove = false;
			});
			
			Events.onContextMenuClose.add(function():void {
				cursor.canMove = true;
			});
			
			// STARTING GAME
			FP.world = level = new TileWorld(Assets.XML_TESTLVL);
		}
		
		public static function changeState(to:String):void {
			if (to != state) {
				var from:String = state;
				state = to;
				Events.onStateChange.dispatch(from, to);
			}
		}
		
		public static function getTileAt(x:int, y:int):Tile {
			return MapController.getTileAt(x, y);
		}
		
		public static function getUnitAt(x:int, y:int, time:int):Unit {
			return MapController.getUnitAt(x, y, time);
		}
		
		public static function getActionsAt(x:int, y:int, time:int):Vector.<Class> {
			var unit:Unit = getUnitAt(x, y, time);
			//var tile:Tile = getTileAt(x, y);
			
			var actionsList:Vector.<Class> = new Vector.<Class>;
			var a:Class;
			if (unit) {
				for each (a in (unit.actions)) {
					if (a["condition"]()) {
						actionsList.push(a);
					}
				}
			}
			
			//if (tile) {
				//for each (a in (tile.actions)) {
					//if (a["condition"]()) {
						//actionsList.push(a);
					//}
				//}
			//}
			
			for each (a in (Game.level.actions)) {
				if (a["condition"]()) {
					actionsList.push(a);
				}
			}
			return actionsList;
		}
		
		public static function timeUp():void {
			TimeController.timeUp();
		}
		
		public static function timeDown():void {
			TimeController.timeDown();
		}
		
		public static function setTime(time:int):void {
			TimeController.setTime(time);
		}
		
		private static function _onLevelStart(level:TileWorld):void {
			// INIT CONTROLLERS
			Debug.init();
			TimeController.init();
			MapController.init();
			MovementController.init();
			CursorController.init();
			SoundController.init();
			state = "idle";
		}
		
		private static function _openContextMenu(x:int, y:int, actions:Vector.<Class>):void {
			_contextMenu = new ContextMenu((0.5 + x) * Game.tileWidth, (0.5 + y) * Game.tileHeight, actions);
			Game.level.add(_contextMenu);
		}
		
		public static function update():void {
			InputController.update();
			FP.console.log("Current time : " + time);
		}
	}

}