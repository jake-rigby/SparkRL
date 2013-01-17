package uk.co.jakerigby.sparkrl.framework.ui.events
{
	import flash.events.Event;
	
	public class ViewEvent extends Event
	{
		public static const CLOSE_REQUESTED:String = "ViewEvent_CLOSE_REQUESTED";
		public static const FRONT_REQUESTED:String = "ViewEvent_FRONT_REQUESTED";
		public static const DRAG:String = "ViewEvent_DRAG";
		public static const STOP_DRAG:String = "ViewEvent_STOP_DRAG";
		public static const RESIZE:String = "ViewEvent_RESIZE";
		public static const STOP_RESIZE:String = "ViewEvent_STOP_RESIZE";
		
		public var resizeStartX:int;
		public var resizeStartY:int;
		
		public function ViewEvent(type:String,resizeStartX:int = -1,resizeStartY:int = -1)
		{
			super(type);
			this.resizeStartX = resizeStartX;
			this.resizeStartY = resizeStartY;
		}
	}
}