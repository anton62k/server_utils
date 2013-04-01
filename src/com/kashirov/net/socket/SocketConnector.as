package com.kashirov.net.socket 
{
	import com.kashirov.net.socket.events.EventConnect;
	import com.kashirov.net.socket.utils.IPacker;
	import com.kashirov.net.socket.utils.IUnpacker;
	import com.kashirov.net.socket.utils.Packer;
	import com.kashirov.net.socket.utils.Unpacker;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.ProgressEvent;
	import flash.net.Socket;
	import flash.utils.ByteArray;
	
	[Event(name = "connect", type = "net.socket.events.EventConnect")]
	[Event(name = "completeData", type = "net.socket.events.EventConnect")]
	
	/**
	 * ...
	 * @author 
	 */
	public class SocketConnector extends EventDispatcher 
	{
		
		private var _host:String;
		private var _port:int;
		private var _packer:IPacker;
		private var _unpacker:IUnpacker;
		private var _log:Function;
		
		private var _socket:Socket;
		
		public function SocketConnector(host:String, port:int, packer:IPacker = null, unpacker:IUnpacker=null, log:Function = null) 
		{
			_host = host;
			_port = port;
			_packer = packer || new Packer();
			_unpacker = unpacker || new Unpacker();
			_log = log;
		}
		
		public function send(message:Message):void
		{
			addLog('send', message.command);
			
			_socket.writeBytes(_packer.execute(message.data()));
			_socket.flush();
		}
		
		public function connect():void 
		{
			addLog('init', _host, _port);
			
			_socket = new Socket(_host, _port);
			_socket.addEventListener(Event.CONNECT, onConnect);
			_socket.addEventListener(ProgressEvent.SOCKET_DATA, onSocketData);
		}
		
		private function readResponse():void 
		{
			var bytes:ByteArray = new ByteArray();
			_socket.readBytes(bytes, 0, _socket.bytesAvailable)
			var data:Object = _unpacker.execute(bytes);
			
			if (data) {
				dispatchEvent(new EventConnect(EventConnect.COMPLETE_DATA, data));
			}
		}		
		
		private function addLog(...args):void
		{
			if (_log != null) _log.apply(null, args);
		}
		
		private function onConnect(e:Event):void 
		{
			addLog('onConnect');
			
			dispatchEvent(new EventConnect(EventConnect.CONNECT));
		}
		
		private function onSocketData(e:ProgressEvent):void 
		{
			addLog('onSocketData', _socket.bytesAvailable, 'bytes');
			
			readResponse();
		}
		
		public function get packer():IPacker { return _packer; }
		
		public function set packer(value:IPacker):void { _packer = value; }
		
		public function get unpacker():IUnpacker { return _unpacker; }
		
		public function set unpacker(value:IUnpacker):void { _unpacker = value; }
		
		public function get log():Function { return _log; }
		
		public function set log(value:Function):void { _log = value; }
		
	}

}