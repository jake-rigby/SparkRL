package uk.co.jakerigby.sparkrl.framework.states
{
	import org.osflash.signals.Signal;

	public class HFStateMachine
	{
		protected var _currentState:HFState;
		protected var _stateChanged:Signal;
		protected var _enableTransitions:Boolean = true;
		protected var _isTransitioning:Boolean = false;
		
		public function get state():HFState
		{
			return _currentState;
		}

		public function get stateChanged():Signal
		{
			return _stateChanged ||= new Signal(HFState);
		}
		
		/**
		 * Learnings:
		 * 
		 * we should never pass a dynamic transition when we are changing the state after the machine has been initialised - all transitions should be predefined
		 * 
		 * if the current state is null, there should be an entry point transition for the target state
		 * 
		 * we are already in a state, look for a transition to the requested state (execution order is defined by the order in which transitions are added to the state at initialisation)
		 */
		public function setState(stateInstance:HFState):Boolean
		{
			if (!_currentState)
			{
				setCurrentState(stateInstance);
				return true;
			}
			
			var state:HFState = _currentState;
			while (state)
			{	
				for (var i:int = 0; i<state.transitions.length; i++)
				{
					if (state.transitions[i].target == stateInstance && state.transitions[i].execute())
					{
						setCurrentState(stateInstance);
						return true;
					}
				}
				state = state.parent;
			}
			return false;
		}
		
		public function addState(state:HFState):void
		{
			state.__machine = this;
		}
		
		private function setCurrentState(state:HFState):void
		{
			// compare hierachys
			var ha:Array = getHierachy(_currentState);
			var hb:Array = getHierachy(state);
			
			// no range errors please..
			while (ha.length < hb.length) ha.push(null);
			while (hb.length > ha.length) hb.push(null);
			
			_isTransitioning = true;
			
			// branch to root, exiting states that change
			for (i=ha.length-1; i>=0; i--)
			{
				if (ha[i] != hb[i] && ha[i] is HFState)
					ha[i].exitState();
			}
			
			// change the state now
			_currentState = state;
			
			// broadcast the state change
			stateChanged.dispatch(_currentState);
			
			_isTransitioning = false;
			
			// root to branch, entering states that change
			for (var i:int=0; i<ha.length; i++)
			{
				if (hb[i] != ha[i] && hb[i] is HFState)
					hb[i].enterState();
			}
		}
		
		private function getHierachy(state:HFState):Array
		{
			var h:Array = [];
			h.unshift(state);
			while (state && state.parent)
			{
				h.unshift(state.parent);
				state = state.parent;
			}
			return h;
		}
	}
}