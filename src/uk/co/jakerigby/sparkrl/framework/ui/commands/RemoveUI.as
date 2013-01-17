package uk.co.jakerigby.sparkrl.framework.ui.commands
{
	import org.robotlegs.mvcs.Command;
	
	import uk.co.jakerigby.sparkrl.framework.ui.events.ViewTrigger;
	import uk.co.jakerigby.sparkrl.framework.ui.models.ViewsModel;
	
	public class RemoveUI extends Command
	{
		[Inject] public var trigger:ViewTrigger;
		[Inject] public var uiModel:ViewsModel;
		
		override public function execute():void
		{
			uiModel.removeView(trigger.view);
		}
	}
}