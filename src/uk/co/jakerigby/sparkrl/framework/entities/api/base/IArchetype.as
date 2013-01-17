package uk.co.jakerigby.sparkrl.framework.entities.api.base
{
	import uk.co.jakerigby.quantification.physical.Value;
	
	[Bindable]
	public interface IArchetype
	{
		function get name():String;
		function get values():Vector.<Value>;
	}
}