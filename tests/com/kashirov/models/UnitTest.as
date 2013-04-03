package com.kashirov.models 
{
	import com.kashirov.models.Unit;
	import flexunit.framework.Assert;
	import org.as3commons.collections.framework.core.MapIterator;
	import org.as3commons.collections.framework.core.SetIterator;
	import org.as3commons.collections.Map;
	
	/**
	 * ...
	 * @author 
	 */
	public class UnitTest extends BaseCase 
	{
		
		public var model:TestModel;
		public var signal:String;
		
		[Before]
		public function before():void
		{
			model = new TestModel();
		}
		
		[After]
		public function after():void
		{
			model.dispose();
		}
		
		[Test]
		public function testInit():void
		{
			eq(model.fieldStr, '');
			eq(model.fieldInt, 0);
			eq(model.fieldBoolean, false);
			eq(model.defaultFieldStr, 'test');
			eq(model.defaultFieldInt, 123);
			eq(model.defaultFieldBoolean, true);
		}
		
		[Test]
		public function testData():void
		{
			eqObj(model.data(), {
				fieldStr: model.fieldStr,
				fieldInt: model.fieldInt,
				fieldBoolean: model.fieldBoolean,
				defaultFieldStr: model.defaultFieldStr,
				defaultFieldInt: model.defaultFieldInt,
				defaultFieldBoolean: model.defaultFieldBoolean
			})
		}
		
		[Test]
		public function testUpdateData():void
		{
			var data:Object = {
				fieldStr: 'test2',
				fieldInt: 1,
				fieldBoolean: true,
				defaultFieldStr: 'test3',
				defaultFieldInt: 456,
				defaultFieldBoolean: false
			}
			model.updateData(data);
			eqObj(model.data(), data);
		}
		
		[Test]
		public function testUpdateField():void
		{
			model.updateField('fieldStr', 'test_update');
			eq(model.fieldStr, 'test_update');
		}
		
		[Test]
		public function testSignal():void
		{
			model.signal.add(onSignal);
			model.updateData( { fieldStr: 'test', fieldInt: 100, fieldBoolean: model.fieldBoolean } );
			eq(signal, '1');
		}
		
		private function onSignal(fields:Array):void 
		{
			eq(fields.length, 2);
			for each (var field:String in fields) 
			{
				eq(model.hasOwnProperty(field), true);
			}
			signal = '1';
		}
		
		[Test]
		public function testSignal2():void
		{
			model.signal.add(onSignal2);
			model.updateField('fieldStr', 'testSignal');
			eq(signal, '2');
		}
		
		private function onSignal2(fields:Array):void
		{
			eq(fields.length, 1);
			eq(fields[0], 'fieldStr');
			eq(model.fieldStr, 'testSignal');
			signal = '2';
		}
		
		[Test]
		public function testForIn():void
		{
			var items:Array = ['defaultFieldBoolean', 'defaultFieldInt', 'defaultFieldStr', 'fieldBoolean', 'fieldInt', 'fieldStr'];
			var i:int = 0;
			for (var name:String in model) 
			{
				eq(items[i], name)
				i ++;
			}
			eq(i, items.length);
		}
		
		[Test]
		public function testForEach():void
		{
			var items:Array = ['defaultFieldBoolean', 'defaultFieldInt', 'defaultFieldStr', 'fieldBoolean', 'fieldInt', 'fieldStr'];
			var i:int = 0;
			for each (var item:* in model) 
			{
				eq(model[items[i]], item);
				i ++;
			}
			eq(i, items.length);
		}
		
		[Test]
		public function testToString():void
		{
			eq(model.toString(), '[object TestModel]');
		}
		
	}

}

import com.kashirov.models.Unit

class TestModel extends Unit {
	
	public var fieldStr:String;
	public var fieldInt:int;
	public var fieldBoolean:Boolean;
	
	public var defaultFieldStr:String = 'test';
	public var defaultFieldInt:int = 123;
	public var defaultFieldBoolean:Boolean = true;
	
}