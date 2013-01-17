package uk.co.jakerigby.sparkrl.framework.ui.events
{
	import flash.events.Event;
	
	import uk.co.jakerigby.sparkrl.framework.ui.components.ViewBase;
	import uk.co.jakerigby.sparkrl.framework.ui.enums.ViewMode;
	
	public class ViewTrigger extends Event
	{
		public static const ADD:String = "UITrigger_ADD";
		public static const REMOVE:String = "UITrigger_REMOVE";
		
		private var _element:ViewBase;
		private var _mode:ViewMode;
		private var _modelClass:Class;
		
		public function ViewTrigger(type:String,element:ViewBase, mode:ViewMode = null, modelClass:Class = null)
		{
			super(type);
			_element = element;
			_mode = mode;
			_modelClass = modelClass;
		}

		public function get modelClass():Class
		{
			return _modelClass;
		}

		public function get view():ViewBase
		{
			return _element;
		}

		public function get mode():ViewMode
		{
			return _mode;
		}
	}
}