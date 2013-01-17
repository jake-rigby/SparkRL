package uk.co.jakerigby.sparkrl.framework.ui.mediators
{
	import org.robotlegs.mvcs.Mediator;
	
	import uk.co.jakerigby.sparkrl.framework.ui.components.ViewBase;
	import uk.co.jakerigby.sparkrl.framework.ui.containers.ViewLayer;
	import uk.co.jakerigby.sparkrl.framework.ui.enums.ViewMode;
	import uk.co.jakerigby.sparkrl.framework.ui.models.ViewsModel;
	
	/**
	 * Listens to the UI model and adds views to the UILayer
	 */
	public class LayerMediator extends Mediator
	{
		[Inject] public var uiModel:ViewsModel;
		[Inject] public var layer:ViewLayer;
		
		private var _views:Vector.<ViewBase>;
		
		override public function onRegister():void
		{
			uiModel.viewAdded.add(onViewAdded);
			uiModel.viewRemoved.add(onViewRemoved);
			uiModel.bringToFrontRequested.add(onBringToFront);
			_views = new Vector.<ViewBase>;
		}
		
		override public function onRemove():void
		{
			uiModel.viewAdded.remove(onViewAdded);
			uiModel.viewRemoved.remove(onViewRemoved);
			uiModel.bringToFrontRequested.remove(onBringToFront);
			_views = null;
		}
		
		private function onViewRemoved(view:ViewBase):void
		{
			if (layer.contains(view))
			{
				layer.removeElement(view);
				_views.splice(_views.indexOf(view),1);
			}
			
			if (_views.length < 1)
			{
				layer.maskEnabled = false;
			}
			
			else
			{
				layer.addElement(layer.modalMask);
				layer.addElement(_views[_views.length-1]);
			}
		}
		
		private function onViewAdded(view:ViewBase):void
		{
			var elementMode:ViewMode = uiModel.getMode(view); // <-- bad
			if (elementMode == layer.mode)
			{
				_views.push(view);
				if (layer.mode == ViewMode.MODAL)
				{
					layer.maskEnabled = true;
					layer.addElement(layer.modalMask);
					view.horizontalCenter = 0;
					view.verticalCenter = 0;
				}
				layer.addElement(view);
			}
		}
		
		private function onBringToFront(view:ViewBase):void
		{
			if (layer.contains(view))
			{
				layer.addElement(view);
			}
		}
	}
}