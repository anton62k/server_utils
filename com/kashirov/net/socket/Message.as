package com.kashirov.net.socket 
{
	import com.junkbyte.console.Cc;
	import flash.utils.describeType;
	
	/**
	 * ...
	 * @author 
	 */
	public class Message 
	{
		
		public var command:String;
		
		public function Message(command:String):void
		{
			this.command = command;
		}
		
		public function data():Object
		{
			var rt:Object = {};
			var structure:XML = describeType(this);
			
			for each (var childNode:XML in structure.variable) {
				var name:String = childNode.@name;
				rt[name] = this[name];
			}
			
			return rt;
		}
		
	}

}