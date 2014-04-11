package 
{
	import com.kashirov.models.vo.MyStore;
	import com.kashirov.models.vo.StoreTop;
	import flash.display.Sprite;
	import flash.utils.getTimer;
	
	/**
	 * ...
	 * @author 
	 */
	public class TestPerformance extends Sprite 
	{
		
		public function TestPerformance() 
		{
			super();
			
			timeDecor('testStoreIncr', testStoreIncr, 100, 0, null);
			timeDecor('testStoreIncr', testStoreIncr, 100, 1, null);
			timeDecor('testStoreIncr', testStoreIncr, 100, 2, null);
			timeDecor('testStoreIncr', testStoreIncr, 100, 3, null);
			timeDecor('testStoreIncr', testStoreIncr, 100, 3, { test: 30 });
			timeDecor('testStoreIncr', testStoreIncr, 500, 0, null);
			timeDecor('testStoreIncr', testStoreIncr, 500, 1, null);
			timeDecor('testStoreIncr', testStoreIncr, 500, 2, null);
			timeDecor('testStoreIncr', testStoreIncr, 500, 3, null);
			timeDecor('testStoreIncr', testStoreIncr, 500, 3, { test: 30 });
			timeDecor('testStoreIncr', testStoreIncr, 1000, 0, null);
			timeDecor('testStoreIncr', testStoreIncr, 1000, 1, null);
			timeDecor('testStoreIncr', testStoreIncr, 1000, 2, null);
			timeDecor('testStoreIncr', testStoreIncr, 1000, 3, null);
			timeDecor('testStoreIncr', testStoreIncr, 1000, 3, { test: 30 } );
			//
			timeDecor('testStore', testStore, 100, 0, null);
			timeDecor('testStore', testStore, 100, 1, null);
			timeDecor('testStore', testStore, 100, 2, null);
			timeDecor('testStore', testStore, 100, 3, null);
			timeDecor('testStore', testStore, 100, 3, { test: 30 });
			timeDecor('testStore', testStore, 500, 0, null);
			timeDecor('testStore', testStore, 500, 1, null);
			timeDecor('testStore', testStore, 500, 2, null);
			timeDecor('testStore', testStore, 500, 3, null);
			timeDecor('testStore', testStore, 500, 3, { test: 30 });
			timeDecor('testStore', testStore, 1000, 0, null);
			timeDecor('testStore', testStore, 1000, 1, null);
			timeDecor('testStore', testStore, 1000, 2, null);
			timeDecor('testStore', testStore, 1000, 3, null);
			timeDecor('testStore', testStore, 1000, 3, { test: 30 });		
		}
		
		private function timeDecor(name:String, func:Function, ...params):void
		{
			var time:Number = getTimer();
			func.apply(null, params);
			trace('[' + name + ']', (getTimer() - time) / 1000, 's', 'params:', params);
		}
		
		private function testStore(count:int, count2:int, data:Object):void 
		{
			var store:StoreTop = new StoreTop();
			
			for (var i:int = 0; i < count; i++) 
			{
				var item:MyStore = store.add(i);
				for (var j:int = 0; j < count2; j++) 
				{
					item.add(j, data);
				}
			}
		}		
		
		private function testStoreIncr(count:int, count2:int, data:Object):void 
		{
			var store:StoreTop = new StoreTop();
			
			for (var i:int = 0; i < count; i++) 
			{
				var item:MyStore = store.add(null);
				for (var j:int = 0; j < count2; j++) 
				{
					item.add(null, data);
				}
			}
		}
		
	}

}