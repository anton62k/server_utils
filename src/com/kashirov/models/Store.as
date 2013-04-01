package com.kashirov.models 
{
	import flash.utils.describeType;
	import flash.utils.getDefinitionByName;
	import org.osflash.signals.Signal;
	/**
	 * ...
	 * @author 
	 */
	public class Store
	{
		
		protected var _models:Object;
		protected var _assign:Class;
		
		public var addSignal:Signal;
		public var removeSignal:Signal;
		
		public function Store() 
		{
			_models = { };
			
			addSignal = new Signal(BaseModel);
			removeSignal = new Signal(BaseModel);
			
			var structure:XML = describeType(this);
			var assignType:String = structure.variable.(@name == 'assign').@type;
			_assign = getDefinitionByName(assignType) as Class;
		}
		
		public function data():Object
		{
			var rt:Object = { };
			
			for (var name:String in _models) 
			{
				var item:BaseModel = getItem(name);
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
				var item:BaseModel = getItem(name);
				item.dispose();
			}
		}
		
		public function getItem(key:String):BaseModel
		{
			return _models[key];
		}
		
		public function addItem(key:String):BaseModel
		{
			var item:BaseModel = new _assign() as BaseModel;
			_models[key] = item;
			item.prefix = key;
			addSignal.dispatch(item);
			return item;
		}
		
		public function removeItem(key:String):BaseModel
		{
			var item:BaseModel = _models[key] as BaseModel;
			delete _models[key];
			removeSignal.dispatch(item);
			item.dispose();
			return item;
		}
		
	}

}
