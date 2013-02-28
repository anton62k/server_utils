package com.kashirov.net.socket.utils
{
	import flash.utils.ByteArray;
	/**
	 * ...
	 * @author 
	 */
	public class Unpacker implements IUnpacker
	{	
		
		public static const HEAD_BYTES:int = 4;
		
		private var objectLength:int;
		private var bufferBytes:ByteArray;
		
		public function execute(data:ByteArray):Object
		{
			var rt:Object;
			
			// new unpack
			if (!bufferBytes) {
				bufferBytes = new ByteArray();
				objectLength = 0;
			}
			
			// read new bytes
			bufferBytes.position = bufferBytes.bytesAvailable;
			data.readBytes(bufferBytes, 0, data.bytesAvailable);
			bufferBytes.position = 0;
			
			// read length object
			if (!objectLength) {
				
				if (bufferBytes.length >= HEAD_BYTES) {
					var head:ByteArray = new ByteArray();
					bufferBytes.readBytes(head, 0, HEAD_BYTES);
					objectLength = head.readUnsignedInt();
				}
				
			}
			
			// read object
			if (bufferBytes.bytesAvailable >= objectLength) {
				rt = bufferBytes.readObject();
				
				bufferBytes = null;
				objectLength = 0;
				
				// TODO Why does "one byte" exist in "bufferBytes"?
			}
			
			return rt;
		}
		
	}

}