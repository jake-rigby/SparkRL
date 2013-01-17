package uk.co.jakerigby.quantification.dimensional
{
	import uk.co.jakerigby.sparkrl.framework.reflection.Enum;

	public class Dim extends Enum
	{
		Enum.erate(Dim);
		
		public static const M:Dim = new Dim();
		public static const L:Dim = new Dim();
		public static const T:Dim = new Dim();
		public static const _:Dim = new Dim();
	}
}