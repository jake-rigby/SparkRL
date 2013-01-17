package uk.co.jakerigby.sparkrl.framework.entities.implementation.components
{
	import flash.geom.Point;
	
	import uk.co.jakerigby.sparkrl.framework.entities.implementation.base.EntityComponent;
	import uk.co.jakerigby.sparkrl.framework.entities.api.components.ISpatial;
	
	public class SpatialComponent extends EntityComponent implements ISpatial
	{
		private var _pos:Point;
		
		public function get pos():Point
		{
			return (_pos ||= new Point()).clone();
		}
		
		public function get x():int
		{
			return (_pos ||= new Point()).x;
		}
		
		public function get y():int
		{
			return (_pos ||= new Point()).y;
		}
		
		public function set x(value:int):void
		{
			(_pos ||= new Point()).x = value;
		}
		
		public function set y(value:int):void
		{
			(_pos ||= new Point()).y = value;
		}
		
		public function set pos(value:Point):void
		{
			_pos = value;
		}
	}
}