package com.kashirov.models 
{
	import com.kashirov.models.BaseModel;
	import flexunit.framework.Assert;
	import org.as3commons.collections.framework.core.SetIterator;
	
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