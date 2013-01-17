package uk.co.jakerigby.sparkrl.framework.execution
{
	import flash.events.IEventDispatcher;
	
	import mx.events.FlexEvent;
	import uk.co.jakerigby.sparkrl.framework.mapping.BucketMap;
	
	/**
	 * To help get around the flex lifecycle
	 */
	public class DeferExecution
	{
		private static var currentCycle:int;
		private static var map:BucketMap = new BucketMap();
		
		/**
		 * Add functions to be executed in a number of life-cycles (default = 1). 
		 * You can stack up a bunch of funtions to be called on subsequent cycles - each step should invalidate properties if used like this
		 * 
		 * TODO : we can abstract this awa from th FlexEvent.UPDATE_COMPLETE Event
		 */
		public static function byCycles(dispatcher:IEventDispatcher,fnctn:Function,cycles:int = 1):void
		{
			var e:ExecutionObject = new ExecutionObject();
			e.fnctn = fnctn;
			e.remaining = cycles;
			map.map(dispatcher,e);
			dispatcher.addEventListener(FlexEvent.UPDATE_COMPLETE,onCycle);
		}
		
		private static function onCycle(event:FlexEvent):void
		{
			var bucket:Array = map.get(event.target);
			if (!bucket)
			{
				// we should no longer be listening to this dispatcher
				IEventDispatcher(event.target).removeEventListener(FlexEvent.UPDATE_COMPLETE,onCycle);
				return;
			}
			for each (var e:ExecutionObject in bucket)
			{
				if (--e.remaining < 1)
				{
					bucket.splice(bucket.indexOf(e),1);
					e.fnctn();
					if (bucket.length<1)
					{
						map.unmap(event.target);
						IEventDispatcher(event.target).removeEventListener(FlexEvent.UPDATE_COMPLETE,onCycle);
					}
				}
			}
			return;
		}
	}

}