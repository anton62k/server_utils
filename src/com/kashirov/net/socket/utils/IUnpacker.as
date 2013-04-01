package com.kashirov.net.socket.utils 
{
	import flash.utils.ByteArray;
	
	/**
	 * ...
	 * @author 
	 */
	public interface IUnpacker 
	{
		
		function execute(data:ByteArray):Object;
		
	}
	
}