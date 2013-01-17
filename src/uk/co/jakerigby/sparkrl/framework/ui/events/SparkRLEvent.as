package uk.co.jakerigby.sparkrl.framework.ui.events
{
	import flash.events.Event;
	
	public class SparkRLEvent extends Event
	{
		public static const STARUP_COMPLETE:String = "FrameWorkEvent_INITIALISED"; 
		
		public function SparkRLEvent(type:String)
		{
			super(type);
		}
	}
}