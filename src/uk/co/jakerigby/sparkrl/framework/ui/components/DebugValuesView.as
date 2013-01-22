package uk.co.jakerigby.sparkrl.framework.ui.components
{
	import mx.collections.ArrayCollection;
	
	import spark.components.DataGroup;
	
	import uk.co.jakerigby.sparkrl.framework.ui.functionality.IUpdater;
	import uk.co.jakerigby.sparkrl.framework.ui.models.DebugModel;

	public class DebugValuesView extends ViewBase
	{
		[Inject] public var debugModel:DebugModel;
		[Inject] public var updater:IUpdater;
		
		[SkinPart] public var values:DataGroup;
		
		override protected function initializationComplete():void
		{
			super.initializationComplete();
			if (updater)
				updater.updater.add(update);
			values.dataProvider = debugModel.watchers;
		}
		
		private function update(delta:int):void
		{
			(values.dataProvider as ArrayCollection).refresh();
		}
	}
}