package uk.co.jakerigby.sparkrl.framework.ui.vos
{
	import flash.events.EventDispatcher;

	[Bindable]
	public class PropWatcher extends EventDispatcher
	{
		private var _instance:*;
		private var _property:String;
		
		public function PropWatcher(instance:*,propery:String)
		{
			_instance = instance;
			_property = propery;
		}

		[Bindable(event="_")] public function get property():String
		{
			return _property;
		}

		[Bindable(event="_")] public function get instance():*
		{
			return _instance;
		}
		
		[Bindable(event="updateValue")]public function get value():String
		{
			if (!_instance || !_property || isNaN(_instance[property])) return null;
			if (_instance[_property] is Number) return String (Number(_instance[_property]).toFixed(3));
			return String(_instance[_property]);
		}
		
		/**
		 * build the debug string here instead - could use anonymous function
		 */
		override public function toString():String
		{
			if (!_instance || !_property || isNaN(_instance[property])) return 'error..'+instance+':'+property;
			return '';
		}

	}
}