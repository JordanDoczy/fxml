package org.fxml {
	import org.fxml.utils.Version;
	import flash.events.Event;

	public interface IApplication {
		
		/**
		* Returns the current version of the Application.
		* @return Version
		*/
		function get version():Version;
		
		/**
		* Pauses the parser on the Application.
		* @param event An optional event can be passed to this function
		*/
		function pause(event:Event=null):void;
		
		/**
		* Resumes the parser on the Application.
		* @param event An optional event can be passed to this function
		*/
		function resume(event:Event=null):void;
		
	}
}
