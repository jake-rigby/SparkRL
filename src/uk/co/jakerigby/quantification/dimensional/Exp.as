package uk.co.jakerigby.quantification.dimensional
{
	import flash.utils.Dictionary;
	
	import uk.co.jakerigby.sparkrl.framework.reflection.Enum;

	public class Exp
	{
		private var _measure:Measure;
		private var _degree:int;
		
		public static function get(measure:Measure,degree:int = 1):Exp
		{
			return new Exp(measure,degree);
		}
		
		public function Exp(measure:Measure,degree:int)
		{
			this._measure = measure;
			this._degree = degree;
		}
		
		public function get degree():int
		{
			return _degree;
		}

		public function get measure():Measure
		{
			return _measure;
		}
		
		public static function evaluate(a:Vector.<Exp>):Vector.<Exp>
		{
			var tally:Dictionary = new Dictionary();
			var i:int, term:Exp;
			for (i=0; i<a.length; i++)
			{
				term = a[i];
				if (term.degree == 0)
					continue;
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

		public static function areEquivalent(a:Vector.<Exp>,b:Vector.<Exp>):Boolean
		{
			// remove degree = zero terms and copy the originals for mutability
			a = evaluate(a);
			b = evaluate(b);
			
			for each (var e:Exp in a) {
				for each (var f:Exp in b) {
					if (e.measure == f.measure) {
						b.splice(b.indexOf(f),1);
						a.splice(a.indexOf(e),1);
					}
				}
			}
			
			return !(a.length || b.length);
			/*
			var tally:Dictionary = new Dictionary();
			var i:int;
			for (i=0; i<a.length; i++)
			{
				if (tally[a[i].measure] == undefined)
					tally[a[i].measure] = a[i].degree;
				else
					tally[a[i].measure] += a[i].degree;
			}
			for (i=0; i<b.length; i++)
			{
				if (tally[b[i].measure] == undefined)
					tally[b[i].measure] = 0 - b[i].degree;
				else
					tally[b[i].measure] -= b[i].degree;
			}
			for (var key:Object in tally)
				if (tally[key] != 0)
					return false;
			return true;
			*/
		}
		
		/**
		 * expressions correspond if they have each have a measure with a common dimension in a non-zero degree term
		 */
		public static function correspond(a:Vector.<Exp>,b:Vector.<Exp>):Boolean
		{
			for each (var e:Exp in a) {
				for each (var f:Exp in b) {
					if (e.degree != 0 && f.degree != 0 && e.measure.dim == f.measure.dim)
						return true;
				}
			}
			return false;
		}
	}
}