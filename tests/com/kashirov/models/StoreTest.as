package com.kashirov.models 
{
	import com.kashirov.models.vo.MyStore;
	import com.kashirov.models.vo.TestSubUnit;
	
	/**
	 * ...
	 * @author 
	 */
	public class StoreTest extends BaseCase 
	{
		
		public var model:MyStore;
		
		[Before]
		public function before():void
		{
			model = new MyStore();
		}
		
		[After]
		public function after():void
		{
			model.dispose();
		}
		
		[Test]
		public function test():void
		{
			eq(model.prefix, '');
		}
		
	}

}
