package uk.co.jakerigby.sparkrl.framework.entities.api.base
{
	import org.robotlegs.core.IInjector;
	[Bindable]
	public interface IEntity
	{
		function get id():String;
		function get name():String;
		function get type():IArchetype;
		function get injector():IInjector;
		function set injector(value:IInjector):void;
		function destroy():void;
	}
}