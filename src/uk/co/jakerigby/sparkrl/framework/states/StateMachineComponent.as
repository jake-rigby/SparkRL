package uk.co.jakerigby.sparkrl.framework.states
{
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	
	import org.osflash.signals.Signal;
	import org.robotlegs.core.IInjector;
	
	import uk.co.jakerigby.sparkrl.framework.entities.implementation.base.EntityComponent;
	import uk.co.jakerigby.sparkrl.framework.mapping.SimpleMap;
	
	public class StateMachineComponent extends EntityComponent
	{
		[Inject] public var injector:IInjector;
		[Inject] public var dispatcher:IEventDispatcher;
		
		protected var _machine:HFStateMachine;
		protected var _states:Vector.<HFState>;
		
		protected var _eventMap:SimpleMap;
		protected var _signalMap:SimpleMap;
		
		public function StateMachineComponent()
		{
			super();
			_states = new Vector.<HFState>;
			
			_eventMap = new SimpleMap();
			_signalMap = new SimpleMap();
		}
		
		public function get machine():HFStateMachine
		{
			return _machine ||= injector.instantiate(HFStateMachine); 
		}
		
		public function get states():Vector.<HFState>
		{
			return _states.concat();
		}
		
		override protected function onRegister():void
		{
			// add the root states and transitions
			configure();
			
			// inject first only into the root states
			for each (var state:HFState in _states)
			{
				if (state && state.__parent == null)
					injector.injectInto(state);
			}
			
			// then configure all states, so everything is instantiated
			for each (state in _states)
			{
				state.configureNow();				
			}
			
			// now inject everything 
			for each (state in _states)
			{
				injector.injectInto(state);
			}
			
			
			mapListeners();
		}
		
		protected function configure():void
		{
			// HOOK
		}
		
		protected function mapListeners():void
		{
			// HOOK
		}
		
		public function addState(clazz:Class):*
		{
			var state:HFState = new clazz();
			
			if (!state)
				return null;

			state.__injector = injector;
			injector.mapValue(clazz,state); 
			machine.addState(state);
			_states.push(state);
			return state;
		}
		
		public function mapEvent(eventType:String,stateInstance:HFState):void
		{
			_eventMap.map(eventType,stateInstance);
			dispatcher.addEventListener(eventType,onEvent);
		}
		
		protected function onEvent(event:Event):void
		{
			var target:HFState = _eventMap.get(event.type) as HFState;
			if (target) 
				machine.setState(target);
		}
		
		public function mapSignal(signal:Signal,targetState:HFState):void
		{
			var listener:Function = function (x:*):void{machine.setState(targetState);};
			_signalMap.map(signal,listener);
			signal.add(listener);
		}
	}
}