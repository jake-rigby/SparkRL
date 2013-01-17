package uk.co.jakerigby.sparkrl.framework.entities.implementation.base
{
	import uk.co.jakerigby.sparkrl.framework.reflection.Enum;
	import uk.co.jakerigby.quantification.physical.Value;
	import uk.co.jakerigby.sparkrl.framework.entities.api.base.IArchetype;
	
	public class Archetype extends Enum implements IArchetype
	{
		// Factory
		public static function get(clazz:Class,name:String, ... args):Archetype
		{
			var archetype:Archetype = new clazz(name);
			
			if (!archetype)
				throw new Error("Class must be subclass of archetype");
			
			for each (var val:Value in args)
			{
				archetype.values.push(val);
			}
			return archetype;
		}
		
		// Definition
		private var _name:String;
		private var _values:Vector.<Value>;
			
		public function Archetype(name:String)
		{
			_name = name;
		}
		
		public function get name():String
		{
			return _name;
		}

		public function get values():Vector.<Value>
		{
			return _values ||= new Vector.<Value>;
		}
	}
}