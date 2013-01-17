package uk.co.jakerigby.utils
{
	import flash.display.Sprite;
	import flash.geom.Point;

	public class ShapeUtils
	{
		
		public static function drawOutlinedCircle(sprite:Sprite, radius:uint, fillColour:uint, lineThickness:uint = 0, lineColour:uint = 0):void
		{
			sprite.graphics.lineStyle(lineThickness, lineColour);
			sprite.graphics.beginFill(fillColour);
			sprite.graphics.drawCircle(0, 0, radius);
			sprite.graphics.endFill();
		}
		
		public static function drawCircle(sprite:Sprite, position:Point, radius:Number, fillColour:uint):void
		{
			sprite.graphics.beginFill(fillColour);
			sprite.graphics.drawCircle(position.x, position.y, radius);
			sprite.graphics.endFill();
		}
		
		public static function drawLine(sprite:Sprite, source:Point, anchor:Point, lineThickness:uint = 1, lineColor:uint = 0):void
		{
			sprite.graphics.moveTo(source.x, source.y);
			sprite.graphics.lineStyle(lineThickness, lineColor);
			sprite.graphics.lineTo(anchor.x, anchor.y);
		}
		
		public static function drawCurve(sprite:Sprite, source:Point, control:Point, anchor:Point, lineThickness:uint = 0, lineColour:uint = 0):void
		{
			sprite.graphics.clear();
			sprite.graphics.moveTo(source.x,source.y);
			sprite.graphics.lineStyle(lineThickness, lineColour);
			sprite.graphics.curveTo(control.x, control.y, anchor.x, anchor.y);
		}
		
		public static function drawRoundedRect(sprite:Sprite, diagonal:Point, cornerRadius:Number, fillColor:uint = 0, lineThickness:uint = 0, lineColor:uint = 0):void
		{
			sprite.graphics.lineStyle(lineThickness, lineColor);
			sprite.graphics.beginFill(fillColor);
			sprite.graphics.drawRoundRect(0, 0, diagonal.x, diagonal.y, cornerRadius, cornerRadius);
			sprite.graphics.endFill();
		}
		
		public static function drawRect(sprite:Sprite, diagonal:Point, fillColor:uint = 0, lineThickness:uint = 0, lineColor:uint = 0):void
		{
			sprite.graphics.lineStyle(lineThickness, lineColor);
			sprite.graphics.beginFill(fillColor);
			sprite.graphics.drawRect(-diagonal.x/2, -diagonal.y/2, diagonal.x, diagonal.y);
			sprite.graphics.endFill();
		}
		
		public static function drawOrigin(sprite:Sprite):void
		{
			sprite.graphics.beginFill(0xff0000);
			sprite.graphics.drawCircle(0,0,2);
			sprite.graphics.endFill();
		}
	}
}