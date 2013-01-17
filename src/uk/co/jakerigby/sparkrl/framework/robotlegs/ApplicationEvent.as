package uk.co.jakerigby.sparkrl.framework.robotlegs
{
	import flash.events.Event;
	
	public class ApplicationEvent extends Event
	{
		public static const UI_INITIALISED:String = "ApplicationEvent_UI_INITIALISED";
		public static const APPLICATION_RUNNING:String = "ApplicationEvent_APPLICATION_RUNNING";
		
		public function ApplicationEvent(type:String)
		{
			super(type);
		}
	}
}