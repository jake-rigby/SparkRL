package uk.co.jakerigby.sparkrl.framework.ui.components
{
	import flash.events.MouseEvent;
	
	import org.osflash.signals.Signal;
	
	import spark.components.supportClasses.SkinnableComponent;
	
	import uk.co.jakerigby.sparkrl.framework.ui.events.ViewEvent;
	import uk.co.jakerigby.sparkrl.framework.ui.functionality.IDisposable;
	
	/**
	 * translates mouse events into ViewEvents so we don't need to write code on the component for it
	 */
	public class ViewBase extends SkinnableComponent implements IDisposable
	{
		/**
		 * all views must have this (skinnable) panel to receive mouse events
		 */
		[SkinPart(required='true')] public var panel:ViewPanel;
		
		/**
		 * provide this optional signal skin part to easilly implement close funtionality
		 */
		[SkinPart] public var close:Signal;
		
		/**
		 * yes, there is a close signal on both the panel and the view base, its a bit weird but flexible
		 */
		override protected function partAdded(partName:String, instance:Object):void
		{
			super.partAdded(partName,instance);
			
			if (instance == close)
				close.add(closeNow);
			
			if (instance == panel)
			{
				panel.addEventListener(MouseEvent.MOUSE_DOWN,onMouseDown);
				panel.addEventListener(MouseEvent.MOUSE_UP,onMouseUp);
				
				//if (panel.closeButtonEnabled)
					//panel.close.add(closeNow);
				
				if (panel.resizeEnabled)
				{
					panel.resizeHandle.addEventListener(MouseEvent.MOUSE_DOWN,startResize);
					//panel.percentHeight = 100;
					//panel.percentWidth = 100;
				}
			}
		}
		
		override protected function partRemoved(partName:String, instance:Object):void
		{
			super.partRemoved(partName,instance);
			
			//if (instance == close)
				//close.remove(closeNow);
			
			if (instance == panel)
			{
				panel.removeEventListener(MouseEvent.MOUSE_DOWN,onMouseDown);
				panel.removeEventListener(MouseEvent.MOUSE_UP,onMouseUp);
				panel.close.remove(closeNow)
			}
		}
		
		protected function onMouseDown(event:MouseEvent):void
		{
			if (event.target != panel.skin) return;
			dispatchEvent(new ViewEvent(ViewEvent.FRONT_REQUESTED));
			dispatchEvent(new ViewEvent(ViewEvent.DRAG));
			event.stopImmediatePropagation();
		}
		
		protected function startResize(event:MouseEvent):void
		{
			if (event.target != panel.resizeHandle) return;
			event.stopImmediatePropagation();
			dispatchEvent(new ViewEvent(ViewEvent.RESIZE,event.stageX,event.stageY));
		}
		
		private function closeNow():void
		{
			dispatchEvent(new ViewEvent(ViewEvent.CLOSE_REQUESTED));
		}
		
		protected function onMouseUp(event:MouseEvent):void
		{
			if (event.currentTarget != panel.skin) return;
			dispatchEvent(new ViewEvent(ViewEvent.STOP_DRAG));
			event.stopImmediatePropagation();
		}
		
		/**
		 * Hook to clean up when a view is removed from the views model
		 */
		public function dispose():void
		{
		}
	}
}