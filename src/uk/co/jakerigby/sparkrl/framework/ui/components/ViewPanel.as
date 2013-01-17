package uk.co.jakerigby.sparkrl.framework.ui.components
{
	import mx.core.UIComponent;
	
	import org.osflash.signals.Signal;
	
	import spark.components.Group;
	import spark.components.SkinnableContainer;
	import spark.primitives.Rect;
	
	import uk.co.jakerigby.sparkrl.framework.ui.skins.panels.ViewPanelSkin;
	
	public class ViewPanel extends SkinnableContainer
	{
		[SkinPart] public var base:Rect;
		
		[SkinPart] public var close:Signal;
		
		[SkinPart] public var resizeHandle:Group;
		
		[Bindable] public var title:String;
		
		[Bindable] public var closeButtonEnabled:Boolean = false;
		
		[Bindable] public var resizeEnabled:Boolean = false;
	}
}