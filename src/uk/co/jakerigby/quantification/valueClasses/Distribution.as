package uk.co.jakerigby.quantification.valueClasses
{
	import uk.co.jakerigby.sparkrl.framework.reflection.Enum;
	
	public class Distribution extends Enum
	{
		Enum.erate(Distribution);
		public static const Continuous:Distribution = new Distribution();
		public static const Discreet:Distribution = new Distribution();
	}
}