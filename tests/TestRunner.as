package  
{
	import com.kashirov.models.StoreTest;
	import com.kashirov.models.UnitSubTest;
	import com.kashirov.models.UnitTest;
	import flash.display.Sprite;
	import org.flexunit.internals.TraceListener;
	import org.flexunit.runner.FlexUnitCore;
	
	/**
	 * ...
	 * @author 
	 */
	public class TestRunner extends Sprite 
	{
		
		public function TestRunner() 
		{
			var core:FlexUnitCore = new FlexUnitCore();
			core.addListener(new TraceListener());
			core.run(UnitTest, UnitSubTest, StoreTest);
		}
		
	}

}