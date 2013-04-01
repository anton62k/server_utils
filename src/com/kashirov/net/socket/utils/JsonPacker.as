package com.kashirov.net.socket.utils 
{
	import flash.utils.ByteArray;
	/**
	 * ...
	 * @author ...
	 */
	public class JsonPacker implements IPacker 
	{
		
		public function execute(data:Object):ByteArray 
		{
			var rt:ByteArray = new ByteArray();
			rt.writeUTFBytes(JSON.stringify(data));
			rt.position = 0;
			return rt;
		}
		
	}

}