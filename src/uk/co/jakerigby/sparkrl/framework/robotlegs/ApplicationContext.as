package uk.co.jakerigby.sparkrl.framework.robotlegs
{
	import org.robotlegs.base.ContextEvent;
	import org.robotlegs.mvcs.Context;
	
	import spark.components.WindowedApplication;
	
	import uk.co.jakerigby.sparkrl.framework.ui.commands.InitViews;
	
	public class ApplicationContext extends Context
	{
		override public function startup():void
		{
			// Map as an alias
			injector.mapValue(WindowedApplication, contextView);
			
			// Map the application mediator
			mediatorMap.mapView(contextView, ApplicationMediator);
			
			// Map the UI startup command
			commandMap.mapEvent(ContextEvent.STARTUP_COMPLETE, InitViews, ContextEvent);
			
			// main hook
			mappings();
			
			super.startup();
		}
		
		protected function mappings():void
		{
		}
		
	}
}