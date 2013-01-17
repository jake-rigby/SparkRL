package uk.co.jakerigby.sparkrl.framework.entities.implementation.base
{
	import org.osflash.signals.Signal;
	import org.robotlegs.mvcs.Actor;
	
	import uk.co.jakerigby.sparkrl.framework.entities.api.base.IEntitiesModel;
	import uk.co.jakerigby.sparkrl.framework.entities.api.base.IEntity;
	
	public class EntitiesModel extends Actor implements IEntitiesModel
	{
		private var _entities:Vector.<IEntity>;
		private var _entityAdded:Signal;
		private var _entityRemoved:Signal;
		
		public function EntitiesModel()
		{
			super();
			_entities = new Vector.<IEntity>;
		}
		
		public function addEntity(entity:IEntity):void
		{
			if (_entities.indexOf(entity)!=-1) return;
			_entities.push(entity);
			entityAdded.dispatch(entity);
		}
		
		public function destroyEntity(entity:IEntity):void
		{
			var idx:int = _entities.indexOf(entity);
			
			if (idx==-1)
				return;
			
			_entities.splice(idx,1).pop().destroy();
			entityRemoved.dispatch(entity);
		}
		
		public function getEntityById(id:String):IEntity
		{
			for each (var entity:IEntity in _entities)
			{
				if (entity.id == id)
					return entity;
			}
			
			return null;
		}
		
		public function getEntitiesByType(entityClass:Class):Vector.<IEntity>
		{
			var result:Vector.<IEntity> = new Vector.<IEntity>;
			for each (var entity:IEntity in _entities)
			{
				if (entity is entityClass)
					result.push(entity);
			}
			
			return result;
		}
		
		public function get entities():Vector.<IEntity>
		{
			return _entities.concat();
		}
		
		public function get entityAdded():Signal
		{
			return _entityAdded ||= new Signal(IEntity);
		}
		
		public function get entityRemoved():Signal
		{
			return _entityRemoved ||= new Signal(IEntity);		
		}
	}
}