package uk.co.jakerigby.sparkrl.framework.entities.implementation.components
{
	import flash.geom.Point;
	
	import mx.events.EffectEvent;
	
	import org.osflash.signals.Signal;
	
	import spark.effects.Animate;
	import spark.effects.animation.MotionPath;
	import spark.effects.animation.SimpleMotionPath;
	
	import uk.co.jakerigby.sparkrl.framework.entities.implementation.base.EntityComponent;
	import uk.co.jakerigby.sparkrl.framework.entities.api.components.IMover;
	import uk.co.jakerigby.sparkrl.framework.entities.api.components.ISpatial;
	
	public class MoverComponent extends EntityComponent implements IMover
	{
		[Inject] public var spatial:ISpatial;
		
		private var _destination:Point;
		private var _moveComplete:Signal;
		
		public function move(p:Point):void
		{
			_destination = p;
			var anim:Animate = new Animate(spatial);
			anim.motionPaths = new Vector.<MotionPath>;
			anim.motionPaths.push(new SimpleMotionPath('x',null,destination.x));
			anim.motionPaths.push(new SimpleMotionPath('y',null,destination.y));
			anim.addEventListener(EffectEvent.EFFECT_END,onMoveComplete);
			anim.play();
		}
		
		protected function onMoveComplete(event:EffectEvent):void
		{
			event.target.removeEventListener(EffectEvent.EFFECT_END,onMoveComplete);
			moveComplete.dispatch();
		}
		
		public function get destination():Point
		{
			return _destination;
		}

		public function get moveComplete():Signal
		{
			return _moveComplete ||= new Signal();
		}

	}
}