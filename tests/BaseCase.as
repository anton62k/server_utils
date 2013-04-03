package  
{
	import flash.utils.describeType;
	import flash.utils.getDefinitionByName;
	import flexunit.framework.Assert;
	
	/**
	 * ...
	 * @author 
	 */
	public class BaseCase 
	{
		
		public function eq(...rest):void
		{
			Assert.assertEquals.apply(null, rest);
		}
		
		public function eqObj(...rest):void
		{
			Assert.assertObjectEquals.apply(null, rest);
		}
		
		public function isInstance(obj:Object, clazz:Class):void
		{
			var structure:XML = describeType(obj);
			var name:String = structure.@name;
			var cl:Class = getDefinitionByName(name) as Class;
			eq(cl, clazz);
		}
		
	}

}