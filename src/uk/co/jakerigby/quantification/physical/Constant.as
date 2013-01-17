package uk.co.jakerigby.quantification.physical
{
	import uk.co.jakerigby.sparkrl.framework.reflection.Enum;
	import uk.co.jakerigby.quantification.dimensional.Exp;
	import uk.co.jakerigby.quantification.dimensional.Measure;
	
	public class Constant extends Enum
	{
		Enum.erate(Constant);
		
		public static const G:Constant = new Constant(
			Value.get(Property.get(Number,Exp.get(Measure.Metre,3), Exp.get(Measure.Kilogram,-1), Exp.get(Measure.Second,-1)), 0.000000000006673)
		);
		
		
		// Definition
		private var _value:Value;
		
		public function Constant(value:Value)
		{
			this._value = value;
		}

		public function get value():Value
		{
			return _value;
		}

		public function get property():Property
		{
			return _value.property;
		}

	}
}