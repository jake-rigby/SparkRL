package uk.co.jakerigby.quantification.dimensional
{
	import uk.co.jakerigby.sparkrl.framework.reflection.Enum;
	
	/**
	 * A Meaure 
	 */
	public final class Measure extends Enum
	{
		Enum.erate(Measure);
		
		public static const Kilogram:Measure = new Measure("kg",Dim.M,1);
		public static const Metre:Measure = new Measure("m",Dim.L,1);
		public static const Second:Measure = new Measure("s",Dim.T,1);
		public static const Dimensionless:Measure = new Measure("",Dim._,1);
		
		public static const Gram:Measure = new Measure("g",Dim.M,0.001);
		
		private var _symbol:String;
		private var _dim:Dim;
		private var _magnitude:Number
		
		public function Measure(symbol:String,dim:Dim,magnitude:Number)
		{
			this._symbol = symbol;
			this._dim = dim;
			this._magnitude = magnitude;
		}

		public function get dim():Dim
		{
			return _dim;
		}

		public function get symbol():String
		{
			return _symbol;
		}

		public function get magnitude():Number
		{
			return _magnitude;
		}
	}
}