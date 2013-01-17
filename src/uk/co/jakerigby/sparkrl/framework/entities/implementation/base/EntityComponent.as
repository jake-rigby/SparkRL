package uk.co.jakerigby.sparkrl.framework.entities.implementation.base
{
	import uk.co.jakerigby.sparkrl.framework.entities.api.base.IEntity;
	import uk.co.jakerigby.sparkrl.framework.entities.api.base.IEntityComponent;

	public class EntityComponent implements IEntityComponent
	{
		private var _entity:IEntity;
		private var _isRegistered:Boolean;
		
		[Inject]
		public function set entity(value:IEntity):void
		{
			_entity = value;
		}
		
		public function get entity():IEntity
		{
			return _entity;
		}
		
		public function get isRegistered():Boolean
		{
			return _isRegistered;
		}
		
		internal function register():void
		{
			//onPreRegister();
			onRegister();
			_isRegistered = true;
		}
		
		internal function remove():void
		{
			//onPreRemove();
			onRemove();
			_isRegistered = false;
		}
		
		protected function onRegister():void
		{
			// HOOK: override
		}
		
		protected function onRemove():void
		{
			// HOOK: override
		}
	}
}