package uk.co.jakerigby.quantification.physical
{
	import uk.co.jakerigby.sparkrl.framework.entities.implementation.base.Entity;
	import uk.co.jakerigby.sparkrl.framework.entities.api.base.IArchetype;
	import uk.co.jakerigby.quantification.dimensional.Unit;

	public class Quantity extends Entity
	{
		private static var __uid:int = 0;
		public static function get uid():String { return "Quantity_"+__uid++;}
		
		private var _archetype:IArchetype;
		private var _qty:Number;
		private var _unit:Unit;
		
		//public function Quantity(id:String,name:String,archetype:IArchetype,quantity:Number,unit:Unit)
		public function Quantity()
		{
			//super(id,name,archetype);
			super();
			//_archetype = archetype;
			//_qty = quantity;
			//_unit = unit;
		}
		
		public function get archetype():IArchetype
		{
			return _archetype;
		}

		public function get qty():Number
		{
			return _qty;
		}
		
		public function get nativeUnit():Unit
		{
			return _unit;
		}
		
		public function getQuantityIn(requestedUnit:Unit = null):Number
		{
			if (requestedUnit == null || requestedUnit == nativeUnit) 
				return _qty;
			
			// eg. native unit = #, requested unit = kg, property to convert with  = unit mass : the conversion will be unit kg^-1
			var conversion:Unit = new Unit("",nativeUnit.getConversionTo(requestedUnit));

			// Get a value of the archetype with dimensions equivalent to the conversion (or the inverse)
			var value:Value;
			for each (var val:Value in archetype.values)
			{
				// we either multiply or divide by the value, depending on the inversion
				if (val.property.unit.hasEquivalentDimensionsTo(conversion) && val.value is Number)
					return qty/val.value;
				
				else if (new Unit("",val.property.unit.inversion).hasEquivalentDimensionsTo(conversion) && val.value is Number)
					return qty * val.value;
			}
			
			// If we have a value we can use
			if (value && value.value is Number)
			{
				return qty/val.value;
			}
						
			/* --- ---- ---- ---- --- To thik about doing...
			
			// now convert the quantity to the requested unit using the list of expressions
			
			// we may only need a single property to do the conversion - search the archetype's values for a property with the dimensions of the requested unit
			for each (var val:Value in archetype.values)
			{
				if (val.property.unit.hasEquivalentDimensionsTo(conversion))
				{
					trace(val.property.unit.symbol);
					
					var valueFactor:Number = 1;
					var factor:Number = 1;
					for each (var exp:Exp in val.property.unit.definition)
					{
						factor *= exp.measure.magnitude;
						
					}
					return factor;
					//var amtRequested:Number = _qty * some function of the magnitudes 
					// Use the Measure class to get the right number to return
				}
				
				// otherwise we have to try chains
			}
			 -------------------  */
			
			return NaN;
		}
	}
}