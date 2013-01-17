package uk.co.jakerigby.sparkrl.framework.ui.renderers
{
	import flash.events.Event;
	
	import mx.core.IDataRenderer;
	
	import spark.components.Label;
	import spark.components.supportClasses.SkinnableComponent;
	
	public class ItemRenderer extends SkinnableComponent implements IDataRenderer
	{
		[SkinClass] public var labelDisplay:Label;
		
		public function set requestedSkin(skinClass:Class):void
		{
			setStyle('skinClass',skinClass);
		}
		
		private var _data:Object;
				
		[Bindable(event="dataChanged")] 
		public function get data():Object
		{
			return _data;
		}
		
		public function set data(value:Object):void
		{
			if (_data == value)
				return;
			
			clear();
			
			_data = value;
			
			if (setModel(value))
				render();
				
			dispatchEvent(new Event("dataChanged"));
		}
		
		/**
		 * cast a passed in model of arbitrary type and use the render function as a hook to build the view from it
		 */
		protected function setModel(value:Object):Boolean
		{
			// eg. in subclass:
 			//	model = value as [model_class];
			//	return model != null;
			
			return false;
		}
		
		/**
		 * hook - use to render from a model set in setModel()
		 */
		protected function render():void
		{
		}
		
		/**
		 * hook - clear up settings made in render()
		 */
		protected function clear():void
		{
		}
	}
}