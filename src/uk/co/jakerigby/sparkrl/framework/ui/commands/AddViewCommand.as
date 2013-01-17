package uk.co.jakerigby.sparkrl.framework.ui.commands
{
	import org.robotlegs.mvcs.Command;
	
	import uk.co.jakerigby.sparkrl.framework.ui.events.ViewTrigger;
	import uk.co.jakerigby.sparkrl.framework.ui.models.ViewsModel;
	
	public class AddViewCommand extends Command
	{
		[Inject] public var trigger:ViewTrigger;
		[Inject] public var viewsModel:ViewsModel;
		
		override public function execute():void
		{
			// add it to the views model, which add its to the diplay list, resulting in mediation
			viewsModel.addView(trigger.view,trigger.mode);
		}
	}
}