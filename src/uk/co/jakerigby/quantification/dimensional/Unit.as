package uk.co.jakerigby.quantification.dimensional
{
	import flash.utils.Dictionary;
	import flash.utils.getDefinitionByName;
	
	import uk.co.jakerigby.sparkrl.framework.reflection.Enum;

	[Bindable] public class Unit extends Enum
	{
		Enum.erate(Unit);
		
		public static const KILOGRAM:Unit = Unit.get("kg",Exp.get(Measure.Kilogram));
		public static const KILOGRAM_PER_UNIT:Unit = Unit.get("kg/#", Exp.get(Measure.Kilogram),Exp.get(Measure.Dimensionless,-1));
		public static const METRE:Unit = Unit.get("m",Exp.get(Measure.Metre));
		public static const SECOND:Unit = Unit.get("s",Exp.get(Measure.Second));
		
		public static const NEWTON:Unit = Unit.get("N",Exp.get(Measure.Kilogram), Exp.get(Measure.Metre), Exp.get(Measure.Second,-2));
		public static const DENSITY:Unit = Unit.get("",Exp.get(Measure.Kilogram), Exp.get(Measure.Metre,-3));
		public static const JOULE:Unit = Unit.get("J",Exp.get(Measure.Kilogram), Exp.get(Measure.Metre,2), Exp.get(Measure.Second,-2));
		public static const LITRE:Unit = Unit.get("",Exp.get(Measure.Metre,3));
		
		public static const UNIT:Unit = Unit.get('#',Exp.get(Measure.Dimensionless,1));
		public static const BOOL:Unit = Unit.get('_');
		
		
		// Utils		
		public static function getSymbolFromDefinition(definition:Vector.<Exp>):String
		{
			var symbol:String = "";
			for (var i:int=0; i<definition.length; i++)
			{
				if (definition[i].degree > 0 || definition[i].degree < 0)
					symbol += definition[i].measure.symbol;
				if (definition[i].degree > 1 || definition[i].degree < 0)
					symbol += "^"+definition[i].degree;
				symbol += " ";
			}
			return symbol;
		}
		
		public function hasEquivalentDimensionsTo(b:Unit):Boolean
		{
			var tally:Dictionary = new Dictionary();
			var i:int, term:Exp;
			for (i=0; i<definition.length; i++)
			{
				term = definition[i];
				if (tally[term.measure] == undefined)
					tally[term.measure] = term.degree;
				else
					tally[term.measure] += term.degree;
			}
			for (i=0; i<b.definition.length; i++)
			{
				term = b.definition[i];
				if (tally[term.measure] == undefined)
					tally[term.measure] = 0 - term.degree;
				else
					tally[term.measure] -= term.degree;
			}
			for (var key:Object in tally)
				if (tally[key] != 0)
					return false;
			return true;
		}
		
		public function getConversionTo(b:Unit):Vector.<Exp>
		{
			if (b == this)
				return Vector.<Exp>([Exp.get(Measure.Dimensionless,1)]);
			
			var tally:Dictionary = new Dictionary();
			var i:int, term:Exp;
			for (i=0; i<definition.length; i++)
			{
				term = definition[i];
				if (tally[term.measure] == undefined)
					tally[term.measure] = term.degree;
				else
					tally[term.measure] += term.degree;
			}
			for (i=0; i<b.definition.length; i++)
			{
				term = b.definition[i];
				if (tally[term.measure] == undefined)
					tally[term.measure] = 0 - term.degree;
				else
					tally[term.measure] -= term.degree;
			}
			var def:Vector.<Exp> = new Vector.<Exp>;
			for (var measure:Object in tally)
			{
				if (tally[measure] != 0)
					def.push(Exp.get((measure as Measure),tally[measure]));
			}
			return def;
		}
		
		public function get inversion():Vector.<Exp>
		{
			var result:Vector.<Exp> = new Vector.<Exp>;
			for (var i:int = 0; i<definition.length; i++)
				result.push(Exp.get(definition[i].measure,definition[i].degree * -1));
			
			return result;
		}
		/*
		public function evaluate(def:Vector.<Exp>):Vector.<Exp>
		{
			var tally:Dictionary = new Dictionary();
			var i:int, term:Exp;
			for (i=0; i<definition.length; i++)
			{
				term = definition[i];
				if (tally[term.measure] == undefined)
					tally[term.measure] = term.degree;
				else
					tally[term.measure] += term.degree;
			}
			var result:Vector.<Exp> = new Vector.<Exp>;
			for (var key:Object in tally)
			{
				if (tally[key] != 0)
					result.push(Exp.get(key as Measure,tally[key]));
			}
			return result;
		}
		*/
		
		
		public static function get(... args):Unit
		{
			var symbol:String = args.shift();
			var definition:Vector.<Exp> = new Vector.<Exp>;
			for (var i:int=0; i<args.length; i++)
			{
				if (args[i] is Exp) definition.push(args[i]);
				else throw new Error("Type error - Unit is defined by Exp parameters")
			}
			return new Unit(symbol,definition);
		}
		
		// Definition
		private var _symbol:String;
		private var _definition:Vector.<Exp>;
	
		public function Unit(symbol:String, definition:Vector.<Exp>) // no ...args constructors as it means we can construct from a Vector of arguments, us a static get
		{
			_symbol = symbol;
			_definition = definition;
		}

		[Bindable("_")] public function get definition():Vector.<Exp>
		{
			return _definition;
		}

		[Bindable("_")] public function get symbol():String
		{
			if (_symbol == "")
				_symbol = getSymbolFromDefinition(_definition);
			return _symbol;
		}
	}
}