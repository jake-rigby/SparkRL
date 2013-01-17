package uk.co.jakerigby.sparkrl.framework.states
{
	public class HFTransition
	{
		public var target:HFState;
		
		/**
		 * HOOK - put guard conditions in here
		 */
		public function execute():Boolean {return true;}
		
		/**
		 * HOOK - put things in here that may dispatch signals the next state has to listen to, when that has been activated (try and avoid this one!)
		 */
		public function postExecution():void {}
		
		/**
		 * Tidy please!
		 */
		public function destroy():void {}
	}
}