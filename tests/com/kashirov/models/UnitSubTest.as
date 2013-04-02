package com.kashirov.models 
{
	import com.kashirov.models.vo.TestSubUnit;
	
	/**
	 * ...
	 * @author 
	 */
	public class UnitSubTest extends BaseCase 
	{
		
		public var model:TestSubUnit;
		public var signal:String;
		
		[Before]
		public function before():void
		{
			model = new TestSubUnit();
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
			eq(model.sub.prefix, 'sub');
			eq(model.store.prefix, 'store');
		}
		
		[Test]
		public function testData():void
		{
			model.sub.test = 12;
			eqObj(model.data(), { sub: { test: 12 }, store: { } } );
		}
		
		[Test]
		public function testUpdateData():void
		{
			model.updateData( { sub: { test: 15 }, store: { '1': { }, '200': { test: 30 }} } );
			eqObj(model.data(), { sub: { test: 15 }, store: { '1': { test: 10 }, '200': { test: 30 }} } );
		}
		
	}

}
