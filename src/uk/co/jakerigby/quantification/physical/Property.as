package uk.co.jakerigby.quantification.physical
{
	import uk.co.jakerigby.sparkrl.framework.reflection.Enum;
	import uk.co.jakerigby.quantification.dimensional.Exp;
	import uk.co.jakerigby.quantification.dimensional.Measure;
	import uk.co.jakerigby.quantification.dimensional.Unit;
	import uk.co.jakerigby.quantification.valueClasses.Colour;
	import uk.co.jakerigby.quantification.valueClasses.Distribution;
	
	public class Property extends Enum // Hummm, not sure properties are a valid concept in this sense
	{
		Enum.erate(Property);
		
		// Fundamental Properties
		public static const DISTRIBUTION:Property = new Property(Distribution,Unit.UNIT);
		public static const DENSITY:Property = new Property(Number,Unit.DENSITY);
		public static const UNIT_MASS:Property = new Property(Number,Unit.KILOGRAM_PER_UNIT);
		public static const ENERGY:Property = new Property(Number,Unit.JOULE);
		public static const VOLUME:Property = new Property(Number,Unit.LITRE);
		public static const FORCE:Property = new Property(Number,Unit.NEWTON);
		public static const COLOUR:Property = new Property(Colour,Unit.UNIT);
				
		/**
		 * The first argument should be the value class describing enumeration of the property.
		 * If it is an enum, that enumerates its possible value allocations 
		 */ 
		public static function get(... args):Property
		{
			var valueClass:Class = args.shift();
			var unit:Unit;	
			if (args.length)
				unit = Unit.get("",args);
			
			var p:Property = new Property(valueClass,unit);
			return p;
		}
		
		
		// Definition
		private var _valueClass:Class;
		private var _unit:Unit;
		
		public function Property(valueClass:Class,unit:Unit)
		{
			this._valueClass = valueClass;
			this._unit = unit;
			// TODO - validate the valueClass with the unit..
		}

		public function get unit():Unit
		{
			return _unit;
		}

		public function get valueClass():Class
		{
			return _valueClass;
		}
	}
}