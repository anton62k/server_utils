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
		}
		
		[Test]
		public function testData():void
		{
			model.sub.test = 12;
			eqObj(model.data(), { sub: { test: 12 } } );
		}
		
		[Test]
		public function testUpdateData():void
		{
			model.updateData( { sub: { test: 15 }} );
			eqObj(model.data(), { sub: { test: 15 } } );
		}
		
	}

}
