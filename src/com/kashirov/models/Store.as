package com.kashirov.models 
{
	import flash.utils.describeType;
	import flash.utils.flash_proxy;
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
		protected var modelFields:Array;
		protected var className:String;
		
		public var addSignal:Signal;
		public var removeSignal:Signal;
		public var prefix:String;
		public var startIndexIncr:int = 0;
		
		public function toString():String
		{
			return '[object ' + className.split('::')[1] + ']';
		}		
		
		override flash_proxy function nextNameIndex(index:int):int 
		{
			if (index < modelFields.length) {
				return index + 1;
			} else {
				return 0;
			}
		}
		
		override flash_proxy function nextName(index:int):String
		{
			return modelFields[index - 1];
		}
		
		override flash_proxy function nextValue(index:int):*
		{
			var field:String = modelFields[index - 1];
			return _models[field];
		}		
		
		public function Store() 
		{
			_models = { };
			modelFields = [];
			
			prefix = '';
			
			addSignal = new Signal(Unit);
			removeSignal = new Signal(Unit);
			
			var structure:XML = describeType(this);
			className = structure.@name;
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
			key = String(key);
			return _models[key];
		}
		
		public function addItem(key:* = null, data:Object = null):Unit
		{
			if (key == null) {
				key = incrKey();
			}
			
			key = String(key);
			if (getItem(key)) return null;
			
			var item:Unit = new _assign() as Unit;
			_models[key] = item;
			item.prefix = key;
			if (data) item.updateData(data);
			updateModelFields();
			addSignal.dispatch(item);
			return item;
		}
		
		public function removeItem(key:*):Unit
		{
			key = String(key);
			var item:Unit = _models[key] as Unit;
			delete _models[key];
			updateModelFields();
			removeSignal.dispatch(item);
			item.dispose();
			return item;
		}
		
		public function removeAll():void
		{
			var modelFields:Array = this.modelFields.slice();
			for each (var key:String in modelFields) 
			{
				removeItem(key);
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
			return modelFields.length
		}
		
		private function updateModelFields():void
		{
			modelFields = [];
			for (var name:String in _models) 
			{
				modelFields.push(name);
			}
			modelFields = modelFields.sort();
		}
		
		private function incrKey():int
		{
			var incr:int = startIndexIncr;
			var nums:Array = [];
			for each (var item:String in modelFields) 
			{
				if (item == '0') {
					nums.push(0);
				} else if (int(item) != 0) {
					nums.push(int(item));
				}
			}
			
			nums = nums.sort(Array.NUMERIC);
			if (nums.length) {
				incr = nums[nums.length - 1] + 1;
			}
			
			return incr;
		}
		
	}

}
