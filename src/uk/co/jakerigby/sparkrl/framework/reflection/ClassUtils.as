package uk.co.jakerigby.sparkrl.framework.reflection
{
	import avmplus.getQualifiedClassName;
	
	import flash.utils.getDefinitionByName;

	public class ClassUtils
	{		
		public static function getAllEnumerations(clazz:Class):Array
		{
			var result:Array = [];
			var type :XML = flash.utils.describeType(clazz);
			for each (var constant :XML in type.constant)
			{
				if (clazz[constant.@name] is clazz)
					result.push(clazz[constant.@name]);
			}
			return result;
		}
	}
}