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
		
		[Test]
		public function testUpdateData():void
		{	
			model.updateData( { 'test': {'test': 55} } );
			eqObj(model.data(), { 'test': { 'test': 55 } } );
		}
		
		[Test]
		public function testCount():void
		{	
			eq(model.count(), 0);
			
			model.addItem(0);
			eq(model.count(), 1);
			
			model.updateData( { '2': { }, '3': { }} );
			eq(model.count(), 3);
			
			model.removeItem(3);
			eq(model.count(), 2);
			
			model.removeAll();
			eq(model.count(), 0);
		}		
		
	}

}
