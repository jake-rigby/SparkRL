package uk.co.jakerigby.sparkrl.framework.entities.api.base
{
	public interface IEntityFactory
	{
		function getInstance(archetype:IArchetype):IEntity; // <-- temporarilly passing in the class until I sort out a map 
	}
}