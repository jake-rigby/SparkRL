package uk.co.jakerigby.quantification.valueClasses
{
	import uk.co.jakerigby.sparkrl.framework.reflection.Enum;
	
	public class Colour extends Enum
	{
		Enum.erate(Colour);
		public static const Clear:Colour = new Colour();
		public static const Red:Colour = new Colour();
		public static const Green:Colour = new Colour();
		public static const Blue:Colour = new Colour();
		public static const Yellow:Colour = new Colour();
	}
}