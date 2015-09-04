package org.fxml.utils {

	/**
	 * Object to describe Versioning.
	 * 
	 * @author		Jordan Doczy
	 * @version		1.0.0.1
	 * @date 		15.08.2010
	 */
	public class Version {
		
		public var Major:uint;
		public var Minor:uint;
		public var Revision:uint;
		public var Build:uint;
		
		/**
		 * Creates a Version object.
		 */
		public function Version(major:uint, minor:uint, revision:uint, build:uint){
			Major = major;
			Minor = minor;
			Revision = revision;
			Build = build;
		}
		
		/**
		 * Returns a formatted string as "Major.Minor.Revision.Build" ex: (1.1.0.19).
		 */
		public function toString():String{
			return Major + "." + Minor + "." + Revision + "." + Build;
		}
		
	}
}
