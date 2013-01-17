package uk.co.jakerigby.sparkrl.framework.ui.renderers
{
	import flash.events.Event;
	
	import mx.core.IDataRenderer;
	
	import spark.components.SkinnableContainer;
	
	/**
	 * 
		// eg. inline method for defining renderer using ItemRendererContainer
	 	<s:DropDownList prompt="Father" id="fatherInp" dataProvider="{hostComponent.malesCache}"/>
			<s:itemRenderer>
				<fx:Component>
					<renderers:ItemRendererContainer>
						<components1:SelectableLabel text="{data.name}"/>
					</renderers:ItemRendererContainer>
				</fx:Component>
			</s:itemRenderer>
		</s:DropDownList>
	 */
	public class ItemRendererContainer extends SkinnableContainer implements IDataRenderer
	{
		private var _data:Object;
		
		public function ItemRendererContainer()
		{
			super();
		}
		
		[Bindable(event="dataChanged")] public function set data(value:Object):void
		{
			if (_data == value)
				return;
			
			clear();
			
			_data = value;
			
			dispatchEvent(new Event("dataChanged"));
		}
		
		public function get data():Object
		{
			return _data;
		}
		
		protected function clear():void
		{
			
		}
	}
}