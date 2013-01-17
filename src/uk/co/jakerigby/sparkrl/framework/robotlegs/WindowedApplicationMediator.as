package uk.co.jakerigby.sparkrl.framework.robotlegs
{
	import flash.events.Event;
	
	import org.robotlegs.mvcs.Mediator;
	
	import spark.components.Application;
	
	public class WindowedApplicationMediator extends Mediator
	{
		[Inject] public var view:Application;
		
		override public function onRegister():void
		{
			// Listen for stage resize
			view.stage.addEventListener(Event.RESIZE,onResize);
		}
		
		private function onResize(event:Event):void
		{
			// Force the application to the stage size
			view.width = view.stage.stageWidth;
			view.height = view.stage.stageHeight;
		}
	}
}