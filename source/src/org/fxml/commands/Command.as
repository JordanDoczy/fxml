package org.fxml.commands {
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;

	/**
	 * Dispatched when the operation has completed.
	 * @eventType <code>flash.events.Event.COMPLETE</code>
	 */
	[Event(name="complete", type="flash.events.Event.COMPLETE")]
	
	/**
	 * The Command class is used to create a delegate to another function.
	 * 
	 * @author		Jordan Doczy
	 * @version		1.0.0.2
	 * @date 		15.08.2010
	 * 
	 * @private
	 */
	public class Command extends EventDispatcher {
		
		/**
		 * @private
		 */
		protected var _delegate:Function;

		/**
		 * @private
		 */
		protected var _errorEvent:String;

		/**
		 * @private
		 */
		protected var _event:String;

		/**
		 * @private
		 */
		protected var _params:Array;

		/**
		 * @private
		 */
		protected var _target:IEventDispatcher;
		
		
		/**
		 * Creates a Command Object
		 * 
		 * @param delegate The function to be executed.
		 * @param target The object that will dispatch an event (optional).
		 * @param event The complete event the target will listen to. If set along with the target, the Command class will dispatch the complete event after it receives a notification from the target (optional).
		 * @param params The parameters to pass to the delegate (optional).
		 * @param errorEvent The error event the target will listen to. If set along with the target, the Command clas will dispatch the complete event after ir receives a notification from the target (optional). This event is the fallback in case the complete event does not fire.
		 */
		public function Command(delegate:Function, target:IEventDispatcher=null, event:String=null, params:Array=null, errorEvent:String=null){
			_delegate = delegate;
			_target = target;
			_event = event;
			_errorEvent = errorEvent;
			_params = params;
		}
		
		/**
		 * Invokes the delegate.
		 * 
		 * If a target and an event were passed to the constrcutor, the Command will wait dispatch 
		 * to dispatch a <code>flash.events.Event.COMPLETE</code> event until the target receives that event.  Otherwise the 
		 * <code>flash.events.Event.COMPLETE</code> will be dispatched immiediately.
		 */
		public function execute():void{
			if(_target != null && _event != null){
				 _target.addEventListener(_event, onOperationComplete, false, 0, true);
				 if(_errorEvent) _target.addEventListener(_errorEvent, onOperationComplete, false, 0, true);
			}
			
			_delegate.apply(null, _params);
			
			if(_target == null || _event == null) onOperationComplete();
		}
		
		/**
		 * Dispatches the <code>flash.events.Event.COMPLETE</code> event.
		 * 
		 * @private 
		 */
		protected function onOperationComplete(e:Event=null):void{
			if(_target != null && _event != null) _target.removeEventListener(_event, onOperationComplete);
			dispatchEvent(new Event(Event.COMPLETE)); 
		}
	}
}
