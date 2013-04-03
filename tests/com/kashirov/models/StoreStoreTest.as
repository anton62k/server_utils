package com.kashirov.models 
{
	import com.kashirov.models.vo.MyStore;
	import com.kashirov.models.vo.StoreTop;
	/**
	 * ...
	 * @author 
	 */
	public class StoreStoreTest extends BaseCase 
	{
		
		public var model:StoreTop;
		
		[Before]
		public function before():void
		{
			model = new StoreTop();
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
			
			var item:MyStore = model.add();
			eq(item.prefix, '0');
			eq(model.get(item.prefix), item);
			eq(model.count(), 1);
			
			model.remove(item.prefix);
			eq(model.count(), 0);
		}
		
		[Test]
		public function testData():void
		{
			var item:MyStore = model.add(1);
			item.add(2);
			eqObj(model.data(), { '1': { '2': { test: 10 } } } );
		}
		
		[Test]
		public function testUpdateData():void
		{
			var data:Object = { '1': { '2': { test: 12 } }, 'test': { '10': { test: 55 } } };
			model.updateData(data);
			eqObj(model.data(), data);
		}
		
	}

}