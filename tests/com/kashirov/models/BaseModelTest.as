package com.kashirov.models 
{
	import com.kashirov.models.BaseModel;
	import flexunit.framework.Assert;
	import org.as3commons.collections.framework.core.MapIterator;
	import org.as3commons.collections.framework.core.SetIterator;
	import org.as3commons.collections.Map;
	
	/**
	 * ...
	 * @author 
	 */
	public class BaseModelTest extends BaseCase 
	{
		
		public var model:TestModel;
		
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
		public function testIterator():void
		{
			var iterator:SetIterator = model.iterator();
			while (iterator.hasNext()) {
				iterator.next();
				eq(model.hasOwnProperty(iterator.current), true);
			}
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
		}
		
		private function onSignal(fields:Map):void 
		{
			eq(fields.size, 2);
			var iterator:MapIterator = fields.iterator() as MapIterator;
			while (iterator.hasNext()) {
				iterator.next();
				eq(model[iterator.key], iterator.current)
			}
		}
		
		[Test]
		public function testSignal2():void
		{
			model.signal.add(onSignal2);
			model.updateField('fieldStr', 'testSignal');
		}
		
		private function onSignal2(fields:Map):void 
		{
			eq(fields.size, 1);
			eq(fields.itemFor('fieldStr'), 'testSignal');
			eq(model.fieldStr, 'testSignal');
		}
		
	}

}

import com.kashirov.models.BaseModel;

class TestModel extends BaseModel {
	
	public var fieldStr:String;
	public var fieldInt:int;
	public var fieldBoolean:Boolean;
	
	public var defaultFieldStr:String = 'test';
	public var defaultFieldInt:int = 123;
	public var defaultFieldBoolean:Boolean = true;
	
}