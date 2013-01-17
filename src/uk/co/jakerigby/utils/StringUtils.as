package uk.co.jakerigby.utils
{
	public class StringUtils
	{
		public static const DAYS:Array = ['Sunday','Monday','Tuesday','Wednesday','Thursday','Friday','Saturday'];
		public static const MONTHS:Array = ['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'];
		public static const ORDINALS:Array = ['th','st','nd','rd','th','th','th','th','th','th'];
		
		
		public static function getDateFromUTCMilliseconds(utcTimeMs:Number) : String
		{
			var d:Date = new Date(utcTimeMs);
			var ord:int = int(String(d.date).charAt(String(d.date).length-1));
			return DAYS[d.day]+' '+MONTHS[d.month]+' '+d.date+ORDINALS[ord]+' '+d.fullYearUTC;
		}
		
		public static function getTimeFromUTCMilliseconds(utcTimeMs:Number, includeMs:Boolean = false) : String
		{
			var d:Date = new Date(utcTimeMs);
			var s:String =
				StringUtils.ensureLeadingZeros(d.hours,2)+':'+
				StringUtils.ensureLeadingZeros(d.minutes,2)+':'+
				StringUtils.ensureLeadingZeros(d.seconds,2);
			if (includeMs) s += '.'+StringUtils.ensureLeadingZeros(d.milliseconds,3);
			return s;
		}
		
		
		public static function ensureLeadingZeros(number:int, numDigits:int) : String
		{
			var s : String = number+"";
			var l : int = s.length;
			var outS : String = s;
			for(var i:int=0; i<numDigits-l; i++){ outS = "0"+outS; }
			return outS;
		}
		
	}
}