package uk.co.jakerigby.sparkrl.framework.entities.implementation.base
{
	import uk.co.jakerigby.sparkrl.framework.entities.api.base.IArchetype;
	import uk.co.jakerigby.sparkrl.framework.entities.api.base.IEntityMap;
	import uk.co.jakerigby.sparkrl.framework.mapping.SimpleMap;
	
	public class EntityMap extends SimpleMap implements IEntityMap
	{
		public function EntityMap()
		{
			// map archetypes to entity classes in the sub-constructor
		}
		
		public function getEntityClass(archetype:IArchetype):Class
		{
			return get(archetype);
		}
	}
}