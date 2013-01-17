package uk.co.jakerigby.sparkrl.framework.mapping
{
	import flash.utils.Dictionary;
	
	/**
	 * one-to-many mapping
	 */
	public class BucketMap
	{
		private var _mappings:Dictionary;
		
		public function map(key:*,value:*):Array
		{
			if (mappings[key] == undefined)
				mappings[key] = [];
			
			(mappings[key] as Array).push(value);
			return mappings[key] as Array;
		}
		
		public function unmap(key:*):void
		{
			delete mappings[key];
		}
		
		public function get(key:*):Array
		{
			return (mappings[key] ||= []) as Array;
		}

		public function get mappings():Dictionary
		{
			return _mappings ||= new Dictionary();
		}
	}
}