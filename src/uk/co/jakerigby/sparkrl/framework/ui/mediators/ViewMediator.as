package uk.co.jakerigby.sparkrl.framework.ui.mediators
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import org.robotlegs.core.IInjector;
	import org.robotlegs.mvcs.Mediator;
	
	import uk.co.jakerigby.sparkrl.framework.ui.components.ViewBase;
	import uk.co.jakerigby.sparkrl.framework.ui.enums.ViewMode;
	import uk.co.jakerigby.sparkrl.framework.ui.events.ViewEvent;
	import uk.co.jakerigby.sparkrl.framework.ui.models.DebugModel;
	import uk.co.jakerigby.sparkrl.framework.ui.models.ViewsModel;
	
	/**
	 * Handles dragging a close requests for any View
	 */
	public class ViewMediator extends Mediator
	{
		// a concenience
		[Inject] public var injector:IInjector;
		
		[Inject] public var uiModel:ViewsModel;
		[Inject] public var viewBase:ViewBase;
		
		[Inject] public var debug:DebugModel;
		
		private var _resizeX:int;
		private var _resizeY:int;		
		private var resizeInitX:int;
		private var resizeInitY:int;
		private var contentPaddingX:int;
		private var contentPaddingY:int;
	
		override public function onRegister():void
		{
			viewBase.addEventListener(ViewEvent.CLOSE_REQUESTED,onCloseRequestsed);
			viewBase.addEventListener(ViewEvent.DRAG,drag);
			viewBase.addEventListener(ViewEvent.STOP_DRAG,stopDrag);
			viewBase.addEventListener(ViewEvent.FRONT_REQUESTED,front);
			viewBase.addEventListener(ViewEvent.RESIZE,startResize);
			if (viewBase.panel.closeButtonEnabled)
				viewBase.panel.close.add(onCloseRequestsed);
		}
		
		protected function startResize(event:ViewEvent):void
		{
			debug.watch(viewBase,"width");
			
			resizeInitX = event.resizeStartX;
			resizeInitY = event.resizeStartY;
			viewBase.stage.addEventListener(MouseEvent.MOUSE_MOVE, resizeMouseMoveHandler, true);
			viewBase.stage.addEventListener(MouseEvent.MOUSE_UP, resizeMouseUpHandler, true);
			contentPaddingX = viewBase.width - viewBase.panel.contentGroup.width;
			contentPaddingY = viewBase.height - viewBase.panel.contentGroup.height;
		}
		
		protected function resizeMouseMoveHandler(event:MouseEvent):void
		{
			event.stopImmediatePropagation();
			
			var newWidth:Number = viewBase.panel.width + event.stageX - resizeInitX; 
			var newHeight:Number = viewBase.panel.height + event.stageY - resizeInitY;
			
			// restrict the width/height
			//if ((newWidth >= viewBase.minWidth) && (newWidth <= viewBase.maxWidth) && (newWidth >= viewBase.panel.contentGroup.contentWidth + contentPaddingX)) {
			if ((newWidth >= viewBase.minWidth) && (newWidth <= viewBase.maxWidth) && (newWidth >= contentPaddingX)){
				viewBase.width = viewBase.panel.width = newWidth;
			}
			//if ((newHeight >= viewBase.minHeight) && (newHeight <= viewBase.maxHeight) && (newHeight >= viewBase.panel.contentGroup.contentHeight + contentPaddingY)) {
			if ((newHeight >= viewBase.minHeight) && (newHeight <= viewBase.maxHeight) && (newHeight >= contentPaddingY)){
				viewBase.height = viewBase.panel.height = newHeight;
			}
			
			resizeInitX = event.stageX;
			resizeInitY = event.stageY;
		}
		
		protected function resizeMouseUpHandler(event:MouseEvent):void
		{
			debug.unwatch(viewBase,"width");
			
			event.stopImmediatePropagation();
			viewBase.stage.removeEventListener(MouseEvent.MOUSE_MOVE, resizeMouseMoveHandler, true);
			viewBase.stage.removeEventListener(MouseEvent.MOUSE_UP, resizeMouseUpHandler, true);
		}
		
		protected function stopDrag(event:Event):void
		{
			if (uiModel.getMode(viewBase)==ViewMode.MODAL) return;
			viewBase.stage.removeEventListener(MouseEvent.MOUSE_UP,stopDrag);
			viewBase.stopDrag();			
		}
		
		protected function drag(event:ViewEvent):void
		{
			if (uiModel.getMode(viewBase)==ViewMode.MODAL) return;
			if (uiModel.isDraggable(viewBase))
			{
				viewBase.startDrag();
				viewBase.stage.addEventListener(MouseEvent.MOUSE_UP,stopDrag);
			}
		}
		
		protected function front(event:ViewEvent):void
		{
			if (uiModel.getMode(viewBase)==ViewMode.MODAL) return;
			uiModel.bringToFront(viewBase);
		}
		
		override public function onRemove():void
		{
			viewBase.removeEventListener(ViewEvent.CLOSE_REQUESTED,onCloseRequestsed);
			viewBase.removeEventListener(MouseEvent.MOUSE_DOWN,drag)
			viewBase.removeEventListener(MouseEvent.MOUSE_UP,stopDrag)
			viewBase.removeEventListener(ViewEvent.FRONT_REQUESTED,front);
			viewBase.addEventListener(ViewEvent.RESIZE,startResize);
			if (viewBase.panel.closeButtonEnabled)
				viewBase.panel.close.remove(onCloseRequestsed);
		}
		
		protected function onCloseRequestsed(event:Event = null):void
		{
			uiModel.removeView(viewBase);
		}
	}
}