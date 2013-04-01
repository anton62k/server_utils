package com.kashirov.net.socket.events 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author 
	 */
	public class EventConnect extends Event 
	{
		
		public static const CONNECT:String = "connect";
		public static const COMPLETE_DATA:String = "completeData";
		
		public var data:Object;
		
		public function EventConnect(type:String, _data:Object=null, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);
			data = _data;
		} 
		
		public override function clone():Event 
		{ 
			return new EventConnect(type, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("EventConnector", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
	}
	
}