package uk.co.jakerigby.sparkrl.framework.entities.implementation.base
{
	import org.robotlegs.core.IInjector;
	
	import uk.co.jakerigby.sparkrl.framework.entities.api.base.IArchetype;
	import uk.co.jakerigby.sparkrl.framework.entities.api.base.IEntity;
	import uk.co.jakerigby.sparkrl.framework.entities.api.base.IEntityComponent;
	
	/**
	 * Pairs with EntityFactory which relies on internal methods
	 */
	public class Entity implements IEntity
	{
		private static var _uid:int = -1;
		public static function get uid():int { return ++_uid;};
		
		private var _id:String;
		private var _name:String;
		private var _type:IArchetype;
		private var _injector:IInjector;
		private var _components:Vector.<IEntityComponent>;
		
		public function Entity()
		{
			_components = new Vector.<IEntityComponent>;
		}
		
		public function get id():String
		{
			return _id;
		}
		
		public function get name():String
		{
			return _name;
		}
		
		public function get type():IArchetype
		{
			return _type;
		}

		public function get injector():IInjector
		{
			return _injector;
		}

		public function set injector(value:IInjector):void
		{
			_injector = value;
			
			// map and inject into our own selves
			_injector.mapValue(IEntity,this);
			
			_injector.mapValue(IInjector,_injector);
			_injector.injectInto(this);
		}

		internal function addComponentsNow():void
		{
			addComponents();
		}
			
		protected function addComponents():void	
		{
			// HOOK
		}
		
		internal function registerComponents():void
		{
			// first inject into each
			for each (var component:EntityComponent in _components)
			{
				injector.injectInto(component);
			}
			
			// now register
			for each (component in _components)
			{
				component.register();
			}
		}
		
		protected function addComponent(componentClass:Class,aliases:Array = null):*
		{
			var component:IEntityComponent = new componentClass();
			
			if (!component)
				return null;
			
			_components.push(component);
			
			injector.mapValue(componentClass,component);
			
			for each (var clazz:Class in aliases)
			{
				if (!clazz)
					continue;
				
				injector.mapValue(clazz,component);
			}

			return component;
		}
		
		public function destroy():void
		{
			throw new Error("not implemented");
		}
		
		
		// internal factory access only (not interfaced)
		internal function setId(value:String):void
		{
			_id = value;
		}

		internal function setName(value:String):void
		{
			_name = value;
		}

		internal function setType(value:IArchetype):void
		{
			_type = value;
		}
	}
}