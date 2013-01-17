package uk.co.jakerigby.sparkrl.framework.ui.commands
{
	import org.osmf.layout.HorizontalAlign;
	import org.robotlegs.mvcs.Command;
	
	import spark.layouts.BasicLayout;
	import spark.layouts.HorizontalLayout;
	import spark.layouts.TileLayout;
	import spark.layouts.VerticalAlign;
	import spark.layouts.VerticalLayout;
	
	import uk.co.jakerigby.sparkrl.framework.reflection.ClassUtils;
	import uk.co.jakerigby.sparkrl.framework.ui.containers.ViewLayer;
	import uk.co.jakerigby.sparkrl.framework.ui.enums.ViewMode;
	
	/**
	 * Set up various named UI layer layouts - TODO use get value here instead of injection, the hadcoded strings bother me
	 */
	public class SetupLayers extends Command
	{
		override public function execute():void
		{
			var layer:ViewLayer;
			for each (var mode:ViewMode in ClassUtils.getAllEnumerations(ViewMode))
			{
				layer = injector.getInstance(ViewLayer,mode.name) as ViewLayer;
				
				if (!layer)
					continue;
				
				// specifically set layouts for these layers if they have been created
				if (mode == ViewMode.BACKGROUND)
				{
					var vlayout:VerticalLayout = new VerticalLayout();
					vlayout.horizontalAlign = HorizontalAlign.CENTER;
					layer.layout = vlayout;
				}
				
				else if (mode == ViewMode.DESKTOP)
					layer.layout = new BasicLayout();
				
				else if (mode == ViewMode.MODAL)
				{
					var blayout:BasicLayout = new BasicLayout();
					//layout.verticalAlign = VerticalAlign.MIDDLE;
					//layout.horizontalAlign = HorizontalAlign.CENTER;
					layer.layout = blayout;
				}
				
				layer.invalidateDisplayList();
			}
		}
	}
}