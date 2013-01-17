package uk.co.jakerigby.sparkrl.framework.robotlegs
{
	import flash.system.Capabilities;
	
	import org.robotlegs.base.ContextEvent;
	import org.robotlegs.mvcs.Context;
	
	import spark.components.Application;
	import spark.components.WindowedApplication;
	
	import uk.co.jakerigby.sparkrl.framework.ui.commands.InitViews;
	
	public class ApplicationContext extends Context
	{
		override public function startup():void
		{
			var isAir : Boolean = (Capabilities.playerType == "Desktop");
			
			if (isAir)
			{
				// Map as an alias
				injector.mapValue(spark.components.Application, contextView);
				
				// Map the application mediator with the Application alias so flasgh apps don't get confused
				mediatorMap.mapView(contextView, WindowedApplicationMediator, [Application,WindowedApplication]);
			}
			else
			{
				// Map an alias
				injector.mapValue(spark.components.Application, contextView);
				
				
				// Map the application mediator
				mediatorMap.mapView(contextView, ApplicationMediator, [Application]);
			}
			
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