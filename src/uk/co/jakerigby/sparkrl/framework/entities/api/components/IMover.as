package uk.co.jakerigby.sparkrl.framework.entities.api.components
{
	import flash.geom.Point;
	
	import org.osflash.signals.Signal;

	public interface IMover
	{
		function move(destination:Point):void;
		function get destination():Point;
		function get moveComplete():Signal;
	}
}