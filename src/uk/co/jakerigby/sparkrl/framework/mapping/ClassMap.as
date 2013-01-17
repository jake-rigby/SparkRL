package uk.co.jakerigby.sparkrl.framework.mapping
{
	import flash.utils.Dictionary;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;

	public class ClassMap
	{
		private static var _mappings:Dictionary = new Dictionary(true);
		
		public static function getPaired(i:*, cls:Class):*
		{
			var context:Dictionary = getContext(i);
			if (context) return context[cls]
			return null;
		}
		
		/*public static function mapp(... args):void
		{
			var defs:Vector.<Class> = new Vector.<Class>;
			var contexts:Vector.<Dictionary> = new Vector.<Dictionary>;
			for each (var cls:Class in args)
			{
				var def:Class = Class(getDefinitionByName(getQualifiedClassName(cls)));
				if (defs.indexOf(def)==-1)
				{
					var context:Dictionary = _mappings[def];
					if (context)
						contexts.push(context);
					else
						defs.push(def);
				}	
				else
					trace("More than one instance of same class found, skipping subsequent instances");
			}
			
			// and if we have more than one context to resolve?
		
			
			var mappings:Vector.<Dictionary> = new Vector.<Dictionary>;
			for each (var mapping:Dictionary in _mappings)
			{
				for each (var otherMapping:Dictionary in _mappings)
				{
					if (mapping === otherMapping)
						continue;
					_mappings[otherMapping] = mapping;
				}
			}
		}*/
		
		public static function map(i:*, j:*, iAlias:Class=null, jAlias:Class=null):void
		{
			iAlias = iAlias ? iAlias : Class(getDefinitionByName(getQualifiedClassName(i)));
			jAlias = jAlias ? jAlias : Class(getDefinitionByName(getQualifiedClassName(j)));
			
			if (iAlias==jAlias) 
				throw new Error("ClassMap.map - cannot be same class");
			
			var iContext:Dictionary = _mappings[i]; 
			var jContext:Dictionary = _mappings[j];
			
			// iContext is used primarily
			if (iContext) 
			{
				iContext[jAlias] = j;
				_mappings[j] = iContext;
				return;
			}
			
			// jContext only used if no iContext
			if (jContext) 
			{
				jContext[iAlias] = i;
				_mappings[i] = jContext;
				return;
			}
			
			// neither exists so we construct a new context
			iContext = createContext(i, iAlias);
			iContext[jAlias] = j;
			_mappings[j] = iContext;
		}
		
		private static function getContext(obj:*):Dictionary
		{
			var context:Dictionary = context[obj];
			return context;
		}
		
		private static function createContext(obj:*, cls:Class):Dictionary
		{
			var context:Dictionary = new Dictionary(true);
			var c:Class = cls ? cls : Class(getDefinitionByName(getQualifiedClassName(obj)));
			context[c] = obj;
			context[obj] = context;
			return context;
		}
	}
}