package uk.co.jakerigby.quantification.physical
{

	public class Value
	{
		public static function get(property:Property,value:*):Value
		{
			if (value is property.valueClass)
			{
				var q:Value = new Value();
				q.property = property;
				q.value = value;
				return q;
			}
			return null;
		}
		
		public var property:Property;
		public var value:*;
	}
}