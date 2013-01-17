package uk.co.jakerigby.sparkrl.framework.mapping
{
	import flash.utils.Dictionary;

	/**
	 * one-to-one mapping
	 */
	public class SimpleMap
	{
		private var _mappings:Dictionary;
		
		public function map(key:*,value:*):void
		{
			mappings[key] = value;
		}
		
		public function get(key:*):*
		{
			if (mappings[key] == undefined)
				return null;
			else
				return mappings[key];
		}

		public function get mappings():Dictionary
		{
			return _mappings ||= new Dictionary();
		}
	}
}