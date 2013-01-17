package uk.co.jakerigby.sparkrl.framework.reflection
{
	import avmplus.getQualifiedClassName;
	
	import flash.utils.describeType;
	import flash.utils.getDefinitionByName;
	
	public class Enum
	{
		public static function erate(inType :*) :void
		{
			var type :XML = flash.utils.describeType(inType);
			for each (var constant :XML in type.constant)
				inType[constant.@name].val = constant.@name;	
		}

		public var val :String;
	}
}