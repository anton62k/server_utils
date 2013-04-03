package com.kashirov.models 
{
	import com.kashirov.models.vo.MyItem;
	import com.kashirov.models.vo.MyStore;
	import com.kashirov.models.vo.TestSubUnit;
	import flash.utils.describeType;
	import flash.utils.getDefinitionByName;
	
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
			eqObj(model.get('test').data(), { test: 55 } );
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
		
		[Test]
		public function testAddAndGet():void
		{
			var item:Unit = model.add(1);
			isInstance(item, MyItem);
			eq(item.prefix, '1');
			eqObj(item.data(), { 'test': 10 } );
			eq(model.get(1), item);
			
			eq(model.add(1), null);
			eq(model.add('1'), null);
			
			model.remove(1);
			eq(model.get(1), null);
			
			item = model.add('1');
			eq(item.prefix, '1');
			isInstance(item, MyItem);
			eq(model.get(1), item);
		}
		
		[Test]
		public function testAddAndData():void
		{
			var item:Unit = model.add(1, { test: 12 } );
			eqObj(item.data(), { test: 12 } );
			eq(item.prefix, '1');
			eq(model.get(1), item);
		}
	}

}
