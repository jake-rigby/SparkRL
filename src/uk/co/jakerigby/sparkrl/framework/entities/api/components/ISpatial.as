package uk.co.jakerigby.sparkrl.framework.entities.api.components
{
	import flash.geom.Point;

	public interface ISpatial
	{
		function get pos():Point;
		function get x():int;
		function set x(value:int):void;
		function get y():int;
		function set y(value:int):void;		
		function set pos(value:Point):void;
	}
}