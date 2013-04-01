package  
{
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
		
	}

}