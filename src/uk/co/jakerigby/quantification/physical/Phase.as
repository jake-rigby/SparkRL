package uk.co.jakerigby.quantification.physical
{
	import uk.co.jakerigby.sparkrl.framework.reflection.Enum;
	
	public class Phase extends Enum
	{
		Enum.erate(Phase);
		
		public static const Liquid:Phase = new Phase();
		public static const Crystal:Phase = new Phase();
		public static const Gas:Phase = new Phase();
	}
}