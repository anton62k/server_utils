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
	public class Store extends Proxy implements IModel
	{
		
		protected var _models:Object;
		protected var _assign:Class;
		protected var modelFields:Array;
		protected var className:String;
		protected var _prefix:String;
		
		private var _addSignal:Signal;
		private var _removeSignal:Signal;
		private var _changeSignal:Signal;
		
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
			
			_addSignal = new Signal(IModel);
			_removeSignal = new Signal(IModel);
			_changeSignal = new Signal(IModel, Object);
			
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
				var item:IModel = getItem(name);
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
				var item:IModel = getItem(name);
				item.dispose();
			}
		}
		
		public function getItem(key:*):IModel
		{
			key = String(key);
			return _models[key];
		}
		
		public function addItem(key:* = null, data:Object = null):IModel
		{
			if (key == null) {
				key = incrKey();
			}
			
			key = String(key);
			if (getItem(key)) return null;
			
			var item:IModel = new _assign() as IModel;
			_models[key] = item;
			item.prefix = key;
			if (data) item.updateData(data);
			updateModelFields();
			addSignal.dispatch(item);
			item.changeSignal.add(onItemSignal);
			return item;
		}
		
		protected function onItemSignal(item:IModel, fields:Object):void 
		{
			changeSignal.dispatch(item, fields);
		}
		
		public function removeItem(key:*):IModel
		{
			key = String(key);
			var item:IModel = _models[key] as IModel;
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
				
				if (getItem(name)) {
					getItem(name).updateData(value);
				} else {
					addItem(name, value);
				}
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
		
		public function get prefix():String 
		{
			return _prefix;
		}
		
		public function set prefix(value:String):void 
		{
			_prefix = value;
		}
		
		public function get addSignal():Signal 
		{
			return _addSignal;
		}
		
		public function get removeSignal():Signal 
		{
			return _removeSignal;
		}
		
		public function get changeSignal():Signal 
		{
			return _changeSignal;
		}
		
	}

}
