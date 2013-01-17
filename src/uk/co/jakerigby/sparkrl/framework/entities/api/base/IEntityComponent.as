package uk.co.jakerigby.sparkrl.framework.entities.api.base
{
	public interface IEntityComponent
	{
		function set entity(value:IEntity) : void;
		function get entity() : IEntity;
		function get isRegistered() : Boolean;
		//function register():void;
		//function remove():void;
	}
}