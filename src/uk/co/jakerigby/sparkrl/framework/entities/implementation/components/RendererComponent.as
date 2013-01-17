package uk.co.jakerigby.sparkrl.framework.entities.implementation.components
{
	import flash.display.Sprite;
	
	import uk.co.jakerigby.sparkrl.framework.entities.implementation.base.EntityComponent;
	import uk.co.jakerigby.sparkrl.framework.entities.api.components.IRenderer;
	
	public class RendererComponent extends EntityComponent implements IRenderer
	{	
		public function draw(canvas:Sprite):void
		{
			throw new Error("not implemented");
		}
	}
}