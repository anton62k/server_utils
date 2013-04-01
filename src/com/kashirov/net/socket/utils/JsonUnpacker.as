package com.kashirov.net.socket.utils
{
	import flash.utils.ByteArray;
	/**
	 * ...
	 * @author 
	 */
	public class JsonUnpacker implements IUnpacker
	{	
		
		private var bufferBytes:ByteArray = new ByteArray();
		
		public function execute(data:ByteArray):Object
		{
			var rt:Object;		
			
			while (data.bytesAvailable) {
				var byte:int = (data.readByte());
				if (byte) {
					bufferBytes.writeByte(byte);
				} else {
					bufferBytes.position = 0;
					rt = JSON.parse(bufferBytes.readUTFBytes(bufferBytes.length));
					bufferBytes = new ByteArray();
				}
			}
			
			return rt;
		}
		
	}

}