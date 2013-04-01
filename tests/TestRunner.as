package  
{
	import com.kashirov.models.BaseModelTest;
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
			core.run(BaseModelTest);
		}
		
	}

}