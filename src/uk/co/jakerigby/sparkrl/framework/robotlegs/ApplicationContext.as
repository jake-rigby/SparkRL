package uk.co.jakerigby.sparkrl.framework.robotlegs
{
	import org.robotlegs.mvcs.Context;
	
	import spark.components.WindowedApplication;
	
	public class ApplicationContext extends Context
	{
		override public function startup():void
		{
			// Map as an alias
			injector.mapValue(WindowedApplication, contextView);
			
			// Map the application mediator
			mediatorMap.mapView(contextView, ApplicationMediator);
			
			// main hook
			mappings();
			
			super.startup();
		}
		
		protected function mappings():void
		{
		}
	}
}