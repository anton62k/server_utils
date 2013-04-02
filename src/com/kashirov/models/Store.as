package com.kashirov.models 
{
	import flash.utils.describeType;
	import flash.utils.getDefinitionByName;
	import flash.utils.Proxy;
	import org.osflash.signals.Signal;
	/**
	 * ...
	 * @author 
	 */
	public class Store extends Proxy
	{
		
		protected var _models:Object;
		protected var _assign:Class;
		
		public var addSignal:Signal;
		public var removeSignal:Signal;
		public var prefix:String;
		
		public function Store() 
		{
			_models = { };
			
			prefix = '';
			
			addSignal = new Signal(Unit);
			removeSignal = new Signal(Unit);
			
			var structure:XML = describeType(this);
			var assignType:String = structure.variable.(@name == 'assign').@type;
			_assign = getDefinitionByName(assignType) as Class;
		}
		
		public function data():Object
		{
			var rt:Object = { };
			
			for (var name:String in _models) 
			{
				var item:Unit = getItem(name);
				rt[name] = item.data();
			}
			
			return rt;
		}
		
		public function dispose():void
		{
			addSignal.removeAll();
			removeSignal.removeAll();
			
			for (var name:String in _models) 
			{
				var item:Unit = getItem(name);
				item.dispose();
			}
		}
		
		public function getItem(key:*):Unit
		{
			return _models[key];
		}
		
		public function addItem(key:*):Unit
		{
			var item:Unit = new _assign() as Unit;
			_models[key] = item;
			item.prefix = key;
			addSignal.dispatch(item);
			return item;
		}
		
		public function removeItem(key:*):Unit
		{
			var item:Unit = _models[key] as Unit;
			delete _models[key];
			removeSignal.dispatch(item);
			item.dispose();
			return item;
		}
		
		public function removeAll():void
		{
			for (var name:String in _models) 
			{
				removeItem(name);
			}
		}
		
		public function updateData(data:Object):void
		{
			for (var name:String in data) 
			{
				var value:Object = data[name];
				
				if (value == null && getItem(name)) {
					removeItem(name);
					continue;
				}
				
				var item:Unit = getItem(name) || addItem(name);
				item.updateData(data[name]);
			}
		}
		
		public function count():int
		{
			var i:int = 0;
			for (var name:String in _models) 
			{
				i ++;
			}
			return i;
		}
		
	}

}
