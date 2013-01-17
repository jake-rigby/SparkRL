package uk.co.jakerigby.sparkrl.framework.ui.models
{
	import flash.events.IEventDispatcher;
	import flash.utils.Dictionary;
	
	import mx.events.EffectEvent;
	
	import org.osflash.signals.Signal;
	import org.robotlegs.mvcs.Actor;
	
	import spark.effects.Fade;
	
	import uk.co.jakerigby.sparkrl.framework.ui.components.ViewBase;
	import uk.co.jakerigby.sparkrl.framework.ui.enums.ViewMode;
	import uk.co.jakerigby.sparkrl.framework.ui.functionality.IDisposable;
	
	public class ViewsModel extends Actor
	{
		private var _views:Vector.<ViewBase>;
		private var _viewAdded:Signal;
		private var _viewRemoved:Signal;
		private var _bringToFrontRequested:Signal;
		private var _modes:Dictionary;
		private var _modalStack:Vector.<ViewBase>;
		
		private var _fadeIn:Fade;
		
		public function ViewsModel()
		{
			_modes = new Dictionary(true);
			_modalStack = new Vector.<ViewBase>;
		}

		protected function get views():Vector.<ViewBase>
		{
			return _views ||= new Vector.<ViewBase>;
		}

		public function get viewAdded():Signal
		{
			return _viewAdded ||= new Signal(ViewBase);
		}
		
		public function getMode(view:ViewBase):ViewMode
		{
			if (views.indexOf(view)==-1) return null;
			return _modes[view];
		}
		
		public function bringToFront(view:ViewBase):void
		{
			bringToFrontRequested.dispatch(view);
		}
		
		public function isDraggable(view:ViewBase):Boolean
		{
			return _modes[view] == ViewMode.DESKTOP;
		}

		public function addView(view:ViewBase,mode:ViewMode = null):void
		{
			if (views.indexOf(view)!=-1)
				return;
			if (!mode) 
				mode = ViewMode.DESKTOP;
			_modes[view] = mode;
			views.push(view);
			if (mode == ViewMode.MODAL)
			{
				for each (var v:ViewBase in views)
					v.enabled = false;
				view.enabled = true;
				_modalStack.push(view);
			}
			
			view.alpha = 0;
			var fadeIn:Fade = new Fade(view);
			fadeIn.alphaTo = 1;
			fadeIn.duration = 200;
			fadeIn.addEventListener(EffectEvent.EFFECT_END,fadeComplete)
			fadeIn.play();
			
			viewAdded.dispatch(view);
			
			// This does not work unless auto mediation is disabled - http://knowledge.robotlegs.org/kb/reference-mvcs-implementation/how-to-mediate-a-flex-popup
			//var app:DisplayObject = FlexGlobals.topLevelApplication as DisplayObject;
			//PopUpManager.addPopUp(elem,app);
		}
		
		protected function fadeComplete(event:EffectEvent):void
		{
			(event.effectInstance as IEventDispatcher).removeEventListener(EffectEvent.EFFECT_END,fadeComplete);
		}
		
		public function removeView(view:ViewBase):void
		{
			if (views.indexOf(view)!=-1)
			{
				if (_modalStack.length && view == _modalStack[_modalStack.length-1])
				{
					_modalStack.pop();
					if (_modalStack.length)
					{
						var m:ViewBase = _modalStack[_modalStack.length-1];
						for each (var v:ViewBase in views)
							v.enabled = (v == m);
					}
					else
					{
						for each (v in views)
							v.enabled = true;
					}
				}
				
				var fadeOut:Fade = new Fade(view);
				fadeOut.alphaTo = 0;
				fadeOut.duration = 200;
				fadeOut.addEventListener(EffectEvent.EFFECT_END,fadeOutComplete)
				fadeOut.play();
				/*
				views.splice(views.indexOf(view),1);
				viewRemoved.dispatch(view);
				view.dispose();
				*/
			}
		}
		
		private function fadeOutComplete(event:EffectEvent):void
		{
			(event.effectInstance as IEventDispatcher).removeEventListener(EffectEvent.EFFECT_END,fadeComplete);
			views.splice(views.indexOf(event.effectInstance.target),1);
			viewRemoved.dispatch(event.effectInstance.target);
			(event.effectInstance.target as IDisposable).dispose();
		}

		public function get viewRemoved():Signal
		{
			return _viewRemoved ||= new Signal(ViewBase);
		}
		
		public function get bringToFrontRequested():Signal
		{
			return _bringToFrontRequested ||= new Signal(ViewBase);
		}
	}
}