package uk.co.jakerigby.sparkrl.framework.ui.enums
{
	import uk.co.jakerigby.sparkrl.framework.reflection.Enum;
	
	public class ViewMode extends Enum
	{
		Enum.erate(ViewMode);
		
		public static const BACKGROUND:ViewMode = new ViewMode("background",0);
		public static const DESKTOP:ViewMode = new ViewMode("desktop",1);
		public static const MODAL:ViewMode = new ViewMode("modal",2);
		
		// Definition
		private var _name:String;
		private var _z:int;
		public function ViewMode(name:String,z:int)
		{
			_name = name;
			_z = z;
		}
		public function get name():String
		{
			return _name;
		}
		public function get z():int
		{
			return _z;
		}
	}
}