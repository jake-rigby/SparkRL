package uk.co.jakerigby.sparkrl.framework.states
{
	import org.robotlegs.core.IInjector;
	
	public class HFState
	{
		[Inject] public var component:StateMachineComponent;
		
		internal var __parent:HFState;
		internal var __injector:IInjector;
		internal var __machine:HFStateMachine;
		
		protected var _name:String;
		
		private var _transitions:Vector.<HFTransition>;
		private var _childStates:Vector.<HFState>;
		
		internal function get transitions():Vector.<HFTransition>
		{
			return _transitions ||= new Vector.<HFTransition>;
		}		
		
		public function addTransition(target:HFState, clazz:Class = null):HFTransition
		{
			if (clazz == null) clazz = HFTransition;
			
			// instantiate here and provide the transition with dependencies from our own injector
			if (__injector)
				var transition:HFTransition = __injector.instantiate(clazz);
			else
				transition = new clazz();
			
			// the class may be invalid
			if (!transition)
				throw new Error("Transition class was not valid");
			
			// target 
			transition.target = target;
			
			// check for dupes
			for each (var t:HFTransition in transitions){
				if (t is clazz && t.target===target) { return null;}
			}			
			
			// add to the list
			transitions.push(transition);
			
			return transition;
		}
		
		internal function configureNow():void
		{
			configure();
		}
		
		protected function addChildState(stateClass:Class):*
		{
			/* make a baby - this manages dependencies in the component, we would rather do it hierachically, here
			var child:HFState = component.addState(stateClass,this);//new stateClass();
			*/
			
			var child:HFState = new stateClass() as HFState;
			
			if (!child)
				return null;

			child.__injector = __injector.createChild();
			child.__injector.mapValue(stateClass,child);
			child.__injector.injectInto(child);
			child.__parent = this;
			
			
			// add it to be injected later
			(_childStates ||= new Vector.<HFState>).push(child);
			return child;
		}
		
		public function get parent():HFState
		{
			return __parent;
		}
		
		public function get machine():HFStateMachine
		{
			if (__parent)
				return __parent.machine;
			else
				return __machine;
		}
		
		internal function enterState():void
		{
			onEnterState();
		}
		
		internal function exitState():void
		{
			onExitState();
		}
		
		/**
		 * HOOK
		 */
		protected function onEnterState():void
		{
		}
		
		/**
		 * HOOK
		 */
		protected function onExitState():void
		{
		}
		
		/**
		 * HOOK - add child states and transitions here
		 */
		protected function configure():void
		{			
		}
		
		public function toString():String
		{
			return _name;
		}
	}
}