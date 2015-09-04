package org.fxml.managers {
	import org.fxml.commands.Command;

	import flash.events.Event;
	import flash.events.EventDispatcher;

	 /**
	 * Dispatched when all commands have completed.
	 * @eventType <code>flash.events.Event.COMPLETE</code>
	 */ 
	[Event(name="complete", type="flash.events.Event")]
	
	/**
	 * A class that bundles several Command objects.
	 * 
	 * @author		Jordan Doczy
	 * @version		1.0.0.1
	 * @date 		15.08.2010
	 * 
	 * @private
	 */
	public class CommandManager extends EventDispatcher {
		
		private var _index:uint = 0;
		private var _isSequential:Boolean = true;
		private var _items:Array = new Array();
		private var _isWorking:Boolean = false;
		
		public function CommandManager(){}
		
		/**
		 * The current item that is being executed.
		 */
		public function get currentItem():Command{
			return _items[_index];
		}
		
		/**
		 * Determines whether the commands will execute sequentially.
		 * 
		 * @default <code>false</code>
		 */
		public function get isSequential():Boolean{
			return _isSequential;
		}
		
		/**
		 * @private
		 */
		public function set isSequential(value:Boolean):void{
			if(_isWorking) return;
			_isSequential = value;
		}
		
		/**
		 * Returns <code>true</code> if the command manager is currently active.
		 */
		public function get isWorking():Boolean{
			return _isWorking;
		}
		
		/**
		 * Adds a command to the manager.
		 * 
		 * @param command The command to add.
		 */
		public function addCommand(command:Command):void{
			_items.push(command);
		}
		
		/**
		 * Resets the command manager to its initial state.
		 */
		public function reset():void{
			_index = 0;
			_isWorking = false;
			removeEvents();
			_items = [];
		}
		
		/**
		 * @see trigger
		 */
		public function start():void{ trigger(); }
		
		/**
		 * Begins executing the commands.
		 */
		public function trigger():void{
			_isWorking = true;
			
			if(_items.length == 0 || _index == _items.length){
				complete();
			}
			else if(isSequential){
				executeItem(_index);
			}
			else{
				for (var i:Number=0; i<_items.length; i++){
					executeItem(i);
				}
			}	
		}
		
		/**
		 * Dispatches a <code>flash.events.Event.COMPLETE</code> event.
		 * 
		 * @private
		 */
		protected function complete():void{
			_isWorking = false;
			dispatchEvent(new Event(Event.COMPLETE));
		}
		
		/**
		 * Executes a command.
		 * 
		 * @private
		 * 
		 * @param index The index of the command to execute.
		 */
		protected function executeItem(index:uint):void{
			var command:Command = Command(_items[index]);
			command.addEventListener(Event.COMPLETE, onCommandComplete);
			command.execute();
		}
		
		/**
		 * Removes all event listeners.
		 * 
		 * @private
		 */
		protected function removeEvents():void{
			var command:Command;
			
			for each(command in _items){
				if(command.hasEventListener(Event.COMPLETE)){
					try{
						command.removeEventListener(Event.COMPLETE, onCommandComplete);
					}
					catch(e:Error){}
				}
			}
		}
		
		/**
		 * Handler for command objects.
		 * 
		 * @private
		 */
		protected function onCommandComplete(event:Event):void{
			Command(event.target).removeEventListener(Event.COMPLETE, onCommandComplete);
			_index++;
			
			if(_index == _items.length) complete();
			else if(isSequential) executeItem(_index);
		}
	}
}