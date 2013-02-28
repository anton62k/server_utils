package com.kashirov.net.socket.utils
{
	import flash.utils.ByteArray;
	/**
	 * ...
	 * @author 
	 */
	public class Packer implements IPacker
	{
		
		public function execute(data:Object):ByteArray
		{
			var body:ByteArray = new ByteArray();
			body.writeObject(data);
			body.position = 0;
			
			var rt:ByteArray = new ByteArray();
			rt.writeUnsignedInt(body.length);
			rt.writeBytes(body);
			rt.position = 0;
			
			return rt;
		}
		
	}

}