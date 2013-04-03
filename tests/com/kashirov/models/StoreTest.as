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
		
		[Test]
		public function testForIn():void
		{
			var ids:Array = [1, 'test1', '2', '100', '3', 'a', '0'];
			for each (var id:* in ids) 
			{
				model.add(id);
			}
			ids = ids.sort();
			
			var i:int = 0;
			for (var name:String in model) 
			{
				eq(ids[i], name);
				i ++;
			}
			eq(i, model.count());
			eq(i, ids.length);
		}
		
		[Test]
		public function testForEach():void
		{
			var ids:Array = [1, 'test1', '2', '100', '3', 'a'];
			for each (var id:* in ids) 
			{
				model.add(id);
			}
			ids = ids.sort();
			
			var i:int = 0;
			for each (var item:Unit in model) 
			{
				eq(String(ids[i]), item.prefix);
				i ++;
			}
			eq(i, model.count());
			eq(i, ids.length);
		}
		
		[Test]
		public function testAddIncr():void
		{	
			model.startIndexIncr = 0;
			for (var i:int = 0; i < 20; i++) 
			{
				var item:Unit = model.add();
				eq(item.prefix, i.toString());
			}
			
			model.removeAll();
			
			model.startIndexIncr = 11;
			for (i = 0; i < 20; i++) 
			{
				item = model.add();
				eq(item.prefix, (i + 11).toString());
			}
		}
		
		[Test]
		public function testToString():void
		{
			eq(model.toString(), '[object MyStore]');
		}
	}

}

class Test1 {
	
	
}
