package uk.co.jakerigby.quantification.containers
{
	import org.osflash.signals.Signal;
	
	import uk.co.jakerigby.sparkrl.framework.entities.api.base.IEntity;

	public interface IContainer extends IEntity
	{
		function get contents():Vector.<IEntity>;
		function add(... args):void;
		function remove(... args):void;
		function get contentAdded():Signal;
		function get contentRemoved():Signal;
		function contains(entity:IEntity):Boolean;
	}
}