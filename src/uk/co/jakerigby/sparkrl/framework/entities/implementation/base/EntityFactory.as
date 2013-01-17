package uk.co.jakerigby.sparkrl.framework.entities.implementation.base
{
	import org.robotlegs.core.IInjector;
	import org.robotlegs.mvcs.Actor;
	
	import uk.co.jakerigby.sparkrl.framework.entities.api.base.IArchetype;
	import uk.co.jakerigby.sparkrl.framework.entities.api.base.IEntity;
	import uk.co.jakerigby.sparkrl.framework.entities.api.base.IEntityFactory;
	import uk.co.jakerigby.sparkrl.framework.entities.api.base.IEntityMap;
	
	/**
	 * this implementation is dependent on internal methods in the Entity implementation in the same package
	 */
	public class EntityFactory extends Actor implements IEntityFactory
	{
		[Inject] public var injector:IInjector;
		[Inject] public var entityMap:IEntityMap;
		
		public function getInstance(archetype:IArchetype):IEntity
		{
			var entityClass:Class = entityMap.getEntityClass(archetype);
			var entity:Entity = new entityClass();
			
			if (!entity)
				throw new Error("The class was not of type IEntity");
			
			entity.injector = injector.createChild();
			
			// internal setters
			entity.setId(String(Entity.uid));
			entity.setName("Entity "+entity.id);
			entity.setType(archetype);
			
			entity.addComponentsNow();
			entity.registerComponents();
			
			return entity;	
		}
	}
}