package uk.co.jakerigby.sparkrl.framework.ui.commands
{
	import mx.core.UIComponent;
	
	import org.robotlegs.mvcs.Command;
	
	import spark.components.WindowedApplication;
	import spark.layouts.BasicLayout;
	
	import uk.co.jakerigby.sparkrl.framework.execution.DeferExecution;
	import uk.co.jakerigby.sparkrl.framework.reflection.ClassUtils;
	import uk.co.jakerigby.sparkrl.framework.ui.components.Alert;
	import uk.co.jakerigby.sparkrl.framework.ui.components.ViewBase;
	import uk.co.jakerigby.sparkrl.framework.ui.containers.ViewLayer;
	import uk.co.jakerigby.sparkrl.framework.ui.enums.ViewMode;
	import uk.co.jakerigby.sparkrl.framework.ui.events.FrameworkEvent;
	import uk.co.jakerigby.sparkrl.framework.ui.events.ViewTrigger;
	import uk.co.jakerigby.sparkrl.framework.ui.mediators.LayerMediator;
	import uk.co.jakerigby.sparkrl.framework.ui.mediators.ViewMediator;
	import uk.co.jakerigby.sparkrl.framework.ui.models.ViewsModel;
	
	public class InitViews extends Command
	{
		[Inject] public var app:WindowedApplication;
		
		private var _uninitialisedLayers:Vector.<ViewLayer>;
		
		override public function execute():void
		{
			// create the Views model
			injector.mapSingleton(ViewsModel);
			
			// mediate the root view
			mediatorMap.mapView(ViewLayer,LayerMediator);
			
			// other framework views
			mediatorMap.mapView(Alert,ViewMediator,[ViewBase,Alert]);
			
			// actually add the layers and map them by name
			var modes:Vector.<ViewMode> =Vector.<ViewMode>( ClassUtils.getAllEnumerations(ViewMode));
			
			// we need to defer declaring them complete for a life cycle so make a check list
			_uninitialisedLayers = new Vector.<ViewLayer>;
			
			app.layout = new BasicLayout();
			
			for each (var mode:ViewMode in modes)
			{
				var layer:ViewLayer = new ViewLayer(mode);
				app.addElement(layer) as ViewLayer;
				layer.depth = mode.z;
				injector.mapValue(ViewLayer,layer,mode.name);
				
				// wait for a flex life cycle to complete - the mediator of the view is fired on the creation complete flex event
				_uninitialisedLayers.push(layer);
				DeferExecution.byCycles(layer,function():void{
					layerInitialised(layer);
				});
			}
			
			commandMap.mapEvent(ViewTrigger.ADD,AddViewCommand,ViewTrigger);
			commandMap.mapEvent(ViewTrigger.REMOVE,RemoveUI,ViewTrigger);
		}
		
		private function layerInitialised(layer:ViewLayer):void
		{
			_uninitialisedLayers.splice(_uninitialisedLayers.indexOf(layer),1);
			if (_uninitialisedLayers.length < 1)
				eventDispatcher.dispatchEvent(new FrameworkEvent(FrameworkEvent.INITIALISED));			
		}
	}
}