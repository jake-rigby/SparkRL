package uk.co.jakerigby.sparkrl.framework.ui.containers
{
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	
	import mx.core.IVisualElement;
	import mx.effects.Fade;
	import mx.events.EffectEvent;
	import mx.graphics.IFill;
	import mx.graphics.SolidColor;
	
	import spark.components.Group;
	import spark.primitives.Rect;
	
	import uk.co.jakerigby.sparkrl.framework.reflection.Enum;
	import uk.co.jakerigby.sparkrl.framework.ui.enums.ViewMode;
	
	public class ViewLayer extends Group
	{
		private var _mode:ViewMode;
		private var _mask:Rect;
		private var _maskEnabled:Boolean;
		
		public function ViewLayer(mode:ViewMode):void
		{
			_mode = mode;
			top = 0;
			left = 0;
			right = 0;
			bottom = 0;
						
			_mask = new Rect();
			_mask.percentWidth = 100;
			_mask.percentHeight = 100;
			_mask.fill = new SolidColor(getStyle('fillNormal'), 0.7);
			_mask.visible = false;
			_mask.includeInLayout = false;
			_maskEnabled = false;
			
			addElement(_mask);
		}
		
		public function get mode():ViewMode
		{
			return _mode;
		}

		[Bindable]
		public function get maskEnabled():Boolean
		{
			return _maskEnabled;
		}

		public function set maskEnabled(value:Boolean):void
		{
			_maskEnabled = value;
			_mask.visible = value;
			_mask.includeInLayout = value;
			if (value) 
			{
				addElement(_mask);
				
				_mask.alpha = 0;
				var fadeIn:Fade = new Fade(_mask);
				fadeIn.alphaTo = 1;
				fadeIn.duration = 200;
				fadeIn.addEventListener(EffectEvent.EFFECT_END,fadeComplete)
				fadeIn.play();

			}
			else 
			{
				
				var fadeOut:Fade = new Fade(_mask);
				fadeOut.alphaTo = 0;
				fadeOut.duration = 200;
				fadeOut.addEventListener(EffectEvent.EFFECT_END,fadeOutComplete)
				fadeOut.play();
			}
		}
		
		protected function fadeComplete(event:EffectEvent):void
		{
			(event.effectInstance as IEventDispatcher).removeEventListener(EffectEvent.EFFECT_END,fadeComplete);
		}
		
		private function fadeOutComplete(event:EffectEvent):void
		{
			(event.effectInstance as IEventDispatcher).removeEventListener(EffectEvent.EFFECT_END,fadeComplete);
			removeElement(_mask);
		}
		
		public function get modalMask():IVisualElement
		{
			return _mask;
		}
	}
}