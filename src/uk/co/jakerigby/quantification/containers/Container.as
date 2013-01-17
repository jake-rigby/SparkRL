package uk.co.jakerigby.quantification.containers
{
	import org.osflash.signals.Signal;
	
	import uk.co.jakerigby.sparkrl.framework.entities.implementation.base.Entity;
	import uk.co.jakerigby.sparkrl.framework.entities.api.base.IArchetype;
	import uk.co.jakerigby.sparkrl.framework.entities.api.base.IEntity;

	public class Container extends Entity implements IContainer
	{
		private var _contents:Vector.<IEntity>;
		private var _contentAdded:Signal;
		private var _contentRemoved:Signal;
		
		//public function Container(id:String,name:String,type:IArchetype)
		public function Container()
		{
			//super(id,name,type);
			super();
			_contents = new Vector.<IEntity>;
		}
		
		public function get contents():Vector.<IEntity>
		{
			return _contents.concat();
		}
		
		public function get contentAdded():Signal
		{
			return _contentAdded ||= new Signal(IEntity);
		}
		
		public function get contentRemoved():Signal
		{
			return _contentRemoved ||= new Signal(IEntity);
		}
		
		public function add(... args):void
		{
			for each (var item:* in args)
			{
				if (item is Array)
				{
					for each (var elem:* in (item as Array)) 
					{
						add(elem);
					}
				}
				
				else if ((item is IEntity) && this.contains(item) == false)
				{
					_contents.push(item);
					contentAdded.dispatch(item);
				}
			}
		}
		
		public function remove(... args):void
		{
			for each (var item:* in args)
			{
				if (item is Array)
				{
					for each (var elem:* in (item as Array)) 
					{
						remove(elem);
					}
				}
					
				else if (item is IEntity)
				{
					var i:int = 0;
					while (i<_contents.length)
					{
						if (_contents[i] === item)
						{
							_contents.splice(i,1);
							contentRemoved.dispatch(item);
						}
						else
							i++;
					}
				}
			}
		}
		
		public function contains(entity:IEntity):Boolean
		{
			for each (var e:IEntity in _contents)
			{
				if (e === entity)
					return true;
			}
			return false;
		}
	}
}