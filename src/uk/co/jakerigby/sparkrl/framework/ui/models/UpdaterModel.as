package uk.co.jakerigby.sparkrl.framework.ui.models
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.utils.getTimer;
	
	import mx.core.FlexGlobals;
	
	import org.osflash.signals.Signal;
	import org.robotlegs.mvcs.Actor;
	
	import uk.co.jakerigby.sparkrl.framework.ui.functionality.IUpdater;
	
	public class UpdaterModel extends Actor implements IUpdater
	{
		private var _intervalMS:int = 60;
		private var _dispatcher:IEventDispatcher;
		private var _last:int = getTimer();
		private var _updater:Signal;
		
		public function get updater():Signal
		{
			return _updater ||= new Signal(int);
		}

		[PostConstruct]
		public function initialise():void
		{
			FlexGlobals.topLevelApplication.stage.addEventListener(Event.ENTER_FRAME,onEnterFrame);
		}
		
		private function onEnterFrame(event:Event):void
		{
			var now:int = getTimer();
			var delta:int = now - _last;
			if (delta > _intervalMS) 
			{
				_last = now;
				updater.dispatch(delta);
			}
		}
		
		protected function get dispatcher():IEventDispatcher
		{
			return _dispatcher ||= new EventDispatcher();
		}
	}
}