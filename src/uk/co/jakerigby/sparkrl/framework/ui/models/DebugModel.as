package uk.co.jakerigby.sparkrl.framework.ui.models
{
	import flash.events.Event;
	import flash.utils.Dictionary;
	
	import mx.collections.ArrayCollection;
	
	import org.robotlegs.mvcs.Actor;
	
	import uk.co.jakerigby.sparkrl.framework.ui.functionality.IUpdater;
	import uk.co.jakerigby.sparkrl.framework.ui.vos.PropWatcher;
	
	public class DebugModel extends Actor
	{
		[Inject] public var updater:IUpdater;
		
		private var _watchers:ArrayCollection;
		
		public function DebugModel()
		{
			super();
			_watchers = new ArrayCollection;
		}
		
		[PostConstruct]
		public function init():void
		{
			updater.updater.add(update);
		}
		
		private function update(delta:int):void
		{
			for each (var watcher:PropWatcher in _watchers)
			{
				watcher.dispatchEvent(new Event("updateValue"));
			}
		}
		
		public function watch(instance:*,property:String):void
		{
			// if instance is string
			_watchers.addItem(new PropWatcher(instance,property));
		}
		
		public function unwatch(instance:*,property:String):void
		{
			var i:int = 0;
			while (i<_watchers.length)
			{
				if (_watchers[i].instance === instance && _watchers[i].property == property)
					_watchers.removeItemAt(i);
				else
					i++;
			}
		}
		
		public function get watchers():ArrayCollection
		{
			return _watchers;
		}
	}
}