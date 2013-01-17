package uk.co.jakerigby.sparkrl.framework.entities.api.base
{
	import org.osflash.signals.Signal;

	public interface IEntitiesModel
	{
		function addEntity(entity:IEntity):void;
		function destroyEntity(entity:IEntity):void;
		function getEntityById(id:String):IEntity;
		function getEntitiesByType(entityClass:Class):Vector.<IEntity>;
		function get entities():Vector.<IEntity>;
		function get entityAdded():Signal;
		function get entityRemoved():Signal;
	}
}