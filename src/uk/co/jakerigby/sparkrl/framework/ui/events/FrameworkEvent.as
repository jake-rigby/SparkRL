package uk.co.jakerigby.sparkrl.framework.ui.events
{
	import flash.events.Event;
	
	public class FrameworkEvent extends Event
	{
		public static const INITIALISED:String = "FrameWorkEvent_INITIALISED"; 
		
		public function FrameworkEvent(type:String)
		{
			super(type);
		}
	}
}